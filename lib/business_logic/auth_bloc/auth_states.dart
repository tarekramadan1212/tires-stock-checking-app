import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthStates{}

class AuthInitStata extends AuthStates{}

class AuthenticatedState extends AuthStates{
  final bool isInvited;
  final User user;
  AuthenticatedState({required this.isInvited, required this.user});
}

class UnAuthenticatedState extends AuthStates{}
