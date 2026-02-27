import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/business_logic/auth_bloc/auth_bloc.dart';
import 'package:supreme/core/services/service_locator.dart';
import 'package:supreme/core/themes/app_themes.dart';
import 'package:supreme/presentation/auth/change_password.dart';
import 'package:supreme/presentation/auth/complete_profile_screen.dart';
import 'package:supreme/presentation/auth/loading_screen.dart';
import 'package:supreme/presentation/auth/login_screen.dart';
import 'package:supreme/presentation/home_page.dart';
import 'business_logic/auth_bloc/auth_states.dart';
import 'core/app_cubit/app_cubit.dart';
import 'core/bloc_observer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/utilities/constants/strings.dart';
import 'core/utilities/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: ConstantString.url,
    anonKey: ConstantString.anonKey,
  );
  await setUpServiceLocator();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => sl<AuthBloc>(), lazy: false),
      ],
      child: BlocListener<AuthBloc, AuthStates>(
        listenWhen: (previous, current) {
          //error
          if (current is AuthErrorState) return true;
          //logging in
          if (previous is! SignInState && current is SignInState) return true;
          // when the user first time logs in it will return true, so user gets navigated to the complete profile screen.
          // then it will return false to prevent the unnecessary rebuilds duo to the token refresh triggers.
          if (previous is SignInState && current is SignInState) {
            return previous.isInvited != current.isInvited;
          }
          //logging out - unauthenticated
          if (current is UnAuthenticatedState && previous is! UnAuthenticatedState) return true;
          if(current is NavigateToChangePasswordScreenState) return true;
          return false;
        },
        listener: (context, state) {
          // SCENARIO: User is Authenticated (via Link, Login, or Auto-Login)
          if (state is SignInState) {
            navigatorKey.currentState?.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => state.isInvited
                    ? const CompleteProfileScreen()
                    : const HomePage(),
              ),
                  (route) => false,
            );
          }
          // SCENARIO: User is not logged in (Startup, Logout, or Session Expiry)
          else if (state is UnAuthenticatedState) {
            navigatorKey.currentState?.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
            );
          }
          // SCENARIO: Something went wrong
          else if (state is AuthErrorState) {
            messengerKey.currentState?.showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
          // SCENARIO: User Received and clicked the Forgot Password Link
          else if(state is NavigateToChangePasswordScreenState)
            {
              navigatorKey.currentState?.push(
                MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
              );
            }

        },
        child: MaterialApp(
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: messengerKey,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: LoadingScreen(),
        ),
      ),
    );
  }
}
