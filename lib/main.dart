import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/business_logic/auth_bloc/auth_bloc.dart';
import 'package:supreme/core/services/service_locator.dart';
import 'package:supreme/core/themes/app_themes.dart';
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
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: BlocListener<AuthBloc, AuthStates>(
          listenWhen: (previous, current) {
            if(current is AuthErrorState) return true;
            if(previous.runtimeType != current.runtimeType) return true;
            if(previous is SignInState && current is SignInState)
              {
                return previous.isInvited != current.isInvited;
              }
            return false;
          },
          listener: (context, state) {
            // SCENARIO: User is Authenticated (via Link, Login, or Auto-Login)
            if (state is SignInState) {
              Navigator.pushAndRemoveUntil(
                context,
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
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
              );
            }

            // SCENARIO: Something went wrong
            else if (state is AuthErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.red),
              );
            }
          },          child: LoadingScreen(),
        ),
      ),
    );
  }
}
