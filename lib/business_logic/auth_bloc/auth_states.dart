abstract class AuthStates{}

class AuthInitStata extends AuthStates{}

class SignInState extends AuthStates{
  final bool isInvited;
  SignInState({required this.isInvited});
}

class GetAllBranchesState extends AuthStates{}

class UnAuthenticatedState extends AuthStates{}

class AuthLoadingState extends AuthStates{}

class AuthErrorState extends AuthStates{
  final String message;
  AuthErrorState(this.message);
}

class ChangeSuccessPasswordState extends AuthStates{}

class ForgetPasswordState extends AuthStates{}

class NavigateToChangePasswordScreenState extends AuthStates{}

enum GetUserDataStatus{
  success,
  error
}
class GetCurrentUserDataState extends AuthStates{
  final GetUserDataStatus dataStatus;
  String? message;
  GetCurrentUserDataState({required this.dataStatus, this.message});
}



