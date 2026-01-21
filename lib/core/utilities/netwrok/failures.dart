abstract class CustomFailure{
  final String message;
  CustomFailure(this.message);
}

class ServerFailure extends CustomFailure {
  ServerFailure(super.message);
}

class AuthFailure extends CustomFailure {
  AuthFailure(super.message);
}

class NetworkFailure extends CustomFailure {
  NetworkFailure(super.message);
}