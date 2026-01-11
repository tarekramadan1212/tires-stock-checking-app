import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final SupabaseClient _client = Supabase.instance.client;
  StreamSubscription<AuthState>? _authSubscription;
  final _appLinks = AppLinks();

  AuthBloc() : super(AuthInitStata()) {
    _appLinks.uriLinkStream.listen((uri) async {
      if (uri.fragment.contains('access_token=')) {
        final Map<String, String> params = Uri.splitQueryString(uri.fragment);
        final refresh = params['refresh_token'];

        if (refresh != null) {
          // This "kicks" Supabase into signing in
          await _client.auth.setSession(refresh);
        }
      }
    });

    _authSubscription = _client.auth.onAuthStateChange.listen((data) {
      final session = data.session;

      print('DEBUG: Auth Event -> ${data.event}');

      if (session != null) {
        final isInvited = session.user.userMetadata?['is_new_user'] ?? true;
        add(SignedInEvent(isInvited: isInvited, user: session.user));
      } else {
        add(SignedOutEvent());
      }
    });

    on<SignedInEvent>(_onSignedInEvent);
    on<SignedOutEvent>(_onSignedOutEvent);
  }

  Future<void> _onSignedInEvent(
    SignedInEvent event,
    Emitter<AuthStates> emit,
  ) async {
    emit(AuthenticatedState(isInvited: event.isInvited, user: event.user));
  }

  Future<void> _onSignedOutEvent(
    SignedOutEvent event,
    Emitter<AuthStates> emit,
  ) async {
    emit(UnAuthenticatedState());
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }

}
