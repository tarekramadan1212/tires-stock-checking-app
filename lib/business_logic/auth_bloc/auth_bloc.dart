import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supreme/data/authentication/auth_repo/base_auth_repo.dart';
import 'package:supreme/data/authentication/models/branch_model.dart';
import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  StreamSubscription<AuthState>? _authSubscription;
  final BaseAuthRepository authRepository;
  final _appLinks = AppLinks();

  AuthBloc({required this.authRepository}) : super(AuthInitStata()) {
    _appLinks.uriLinkStream.listen((uri) async {
      if (uri.fragment.contains('access_token=')) {
        final Map<String, String> params = Uri.splitQueryString(uri.fragment);
        final refresh = params['refresh_token'];

        if (refresh != null) {
          // This "kicks" Supabase into signing in
          await authRepository.setSession(refresh);
        }
      }
    });

    _authSubscription = authRepository.authStateStream.listen((data) {
      final session = data.session;
      final event = data.event;

      if (session != null) {
        final isInvited = session.user.userMetadata?['is_new_user'] ?? true;
        add(SignedInEvent(isInvited: isInvited));
      } else {
        add(UnAuthenticatedEvent());
      }
      if(event == AuthChangeEvent.passwordRecovery)
        {
          add(NavigateToChangePasswordScreenEvent());
        }
    });
    on<SignedInEvent>(_onSignedInEvent);
    on<SignedOutEvent>(_onSignedOutEvent);
    on<UnAuthenticatedEvent>(_onUnAuthenticatedEvent);
    on<CompleteProfileEvent>(_onCompleteProfileEvent);
    on<GetAllBranchesEvent>(_onGetAllBranchesEvent);
    on<SignInWithEmailAndPasswordEvent>(_onSignInWithEmailAndPasswordEvent);
    on<ChangePasswordEvent>(_onChangePasswordEvent);
    on<ForgetPasswordEvent>(_onForgetPasswordEvent);
    on<NavigateToChangePasswordScreenEvent>(_onNavigateToChangePasswordScreenEvent);


  }

  ///rather than emitting a new state for each change and depending on the state
  ///itself for the transition, i will depend only on the real source of the truth
  ///which is the stream of the authStateStream.
  ///cause any change or update in the supabase auth it will fire the authStateStream with those changes.
  /// so depending on it will be the most safe way to handle the app.

  Future<void> _onSignedInEvent(
    SignedInEvent event,
    Emitter<AuthStates> emit,
  ) async {
    emit(SignInState(isInvited: event.isInvited));
  }

  Future<void> _onSignInWithEmailAndPasswordEvent(
    SignInWithEmailAndPasswordEvent event,
    Emitter<AuthStates> emit,
  ) async {
    emit(AuthLoadingState());
    final result = await authRepository.signInWithPassword(
      email: event.email,
      password: event.password,
    );
    result.fold((failure) => emit(AuthErrorState(failure.message)), (_) {
      // We emit NOTHING on success!
      // Why? Because the authStateStream will automatically
      // detect the login and emit the SignInState for us.
    });
  }

  Future<void> _onSignedOutEvent(
    SignedOutEvent event,
    Emitter<AuthStates> emit,
  ) async {
    emit(AuthLoadingState());
    final result = await authRepository.signOut();
    result.fold((failure) => emit(AuthErrorState(failure.message)), (_) {
      // will not emit logout state because the authStateStream will automatically
      // detect the logout and emit the UnAuthenticatedState for us.
    });
  }

  void _onUnAuthenticatedEvent(
    UnAuthenticatedEvent event,
    Emitter<AuthStates> emit,
  ) {
    emit(UnAuthenticatedState());
  }

  List<BranchModel> get branches => _branches;
  List<BranchModel> _branches = [];

  Future<void> _onGetAllBranchesEvent(
    GetAllBranchesEvent event,
    Emitter<AuthStates> emit,
  ) async {
    final result = await authRepository.fetchBranches();
    result.fold(
      (failure) {
        emit(AuthErrorState(failure.message));
      },
      (branches) {
        _branches = branches;
        emit(GetAllBranchesState());
      },
    );
  }

  Future<void> _onCompleteProfileEvent(
    CompleteProfileEvent event,
    Emitter<AuthStates> emit,
  ) async {
    emit(AuthLoadingState());
    final result = await authRepository.updateProfileCompletion(
      userMetadata: event.userMetadata,
      password: event.password,
    );
    result.fold((failure) => emit(AuthErrorState(failure.message)), (_) {
      //same as previous methods. on success will emit no thing.
      // The stream will handel it by emitting the SignInState with isInvited = false.
    });
  }

  Future<void> _onChangePasswordEvent(ChangePasswordEvent event, Emitter<AuthStates> emit) async
  {
    emit(AuthLoadingState());
    final result = await authRepository.changePassword(newPassword: event.password);
    result.fold((failure) => emit(AuthErrorState(failure.message)), (_)=> ChangeSuccessPasswordState());
  }

  Future<void> _onForgetPasswordEvent(ForgetPasswordEvent event, Emitter<AuthStates> emit)async
  {
    emit(AuthLoadingState());
    final result = await authRepository.forgetPassword(email: event.email);
    result.fold((failure) => emit(AuthErrorState(failure.message)), (_)=> ForgetPasswordState());
  }

  void _onNavigateToChangePasswordScreenEvent(NavigateToChangePasswordScreenEvent event, Emitter<AuthStates> emit)
  {
    emit(NavigateToChangePasswordScreenState());
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
