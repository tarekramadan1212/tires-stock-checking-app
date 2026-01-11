import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/business_logic/auth_bloc/auth_bloc.dart';
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
  // This converts the PostgrestFilterBuilder into a List<Map<String, dynamic>>
  //final List<Map<String, dynamic>> data = await supabase.from('waiting_customers').select('*');
  //print('THE DATA : ${data.isEmpty}');
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
        BlocProvider(create: (context) => AuthBloc(), lazy: false),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: BlocListener<AuthBloc, AuthStates>(
          listenWhen: (previous, current){
            if (previous is! AuthenticatedState && current is AuthenticatedState) return true;

            if (previous is AuthenticatedState && current is AuthenticatedState) {
              return previous.isInvited != current.isInvited;
            }
            if(previous is AuthenticatedState && current is UnAuthenticatedState) return true;
            if (previous is! AuthenticatedState && current is UnAuthenticatedState) return true;

            return false;
          },
          listener: (context, state) {

            if(state is AuthenticatedState && state.isInvited)
              {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const CompleteProfileScreen()),
                      (route) => false,

                );

              }
            else if(state is AuthenticatedState && !state.isInvited)
              {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                );
              }
            else if(state is UnAuthenticatedState)
              {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                );

              }

          },
          child: LoadingScreen(),
        ),
      ),
    );
  }
}
