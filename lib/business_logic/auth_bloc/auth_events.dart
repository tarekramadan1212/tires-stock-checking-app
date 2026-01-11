import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthEvents{}

class SignedInEvent extends AuthEvents{
  final bool isInvited;
  final User user;
  SignedInEvent({required this.isInvited, required this.user});
}

class SignedOutEvent extends AuthEvents{}

class UserUpdatedEvent extends AuthEvents{}

class PasswordRecoveryEvent extends AuthEvents{}

class UserDeletedEvent extends AuthEvents{}






