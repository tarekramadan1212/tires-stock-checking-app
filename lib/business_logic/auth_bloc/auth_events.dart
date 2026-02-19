abstract class AuthEvents{}

class SignedInEvent extends AuthEvents{
  final bool isInvited;
  SignedInEvent({required this.isInvited});
}

class SignedOutEvent extends AuthEvents{}

class UnAuthenticatedEvent extends AuthEvents{}

class CompleteProfileEvent extends AuthEvents{
  final Map<String, dynamic> userMetadata;
  final String password;
  CompleteProfileEvent({required this.userMetadata, required this.password});
}

class GetAllBranchesEvent extends AuthEvents{}

class SignInWithEmailAndPasswordEvent extends AuthEvents{
  final String email;
  final String password;
  SignInWithEmailAndPasswordEvent({required this.email, required this.password});

}

class ChangePasswordEvent extends AuthEvents{
  final String password;
  ChangePasswordEvent({required this.password});

}

class ForgetPasswordEvent extends AuthEvents{
  final String email;
  ForgetPasswordEvent({required this.email});

}

class NavigateToChangePasswordScreenEvent extends AuthEvents{}









