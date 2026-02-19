import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supreme/data/authentication/models/branch_model.dart';
import '../../../core/utilities/netwrok/failures.dart';

abstract class BaseAuthRepository {
  Future<Either<CustomFailure, List<BranchModel>>> fetchBranches();

  Future<Either<CustomFailure, Unit>> updateProfileCompletion({required Map<String, dynamic> userMetadata, required String password});

  Future<Either<CustomFailure, Unit>> signInWithPassword({required String email, required String password});

  Future<Either<CustomFailure, Unit>> signOut();

  Future<Either<CustomFailure, Unit>> changePassword({required String newPassword});

  Future<Either<CustomFailure, Unit>> forgetPassword({required String email});

  Future<Either<CustomFailure, Unit>> setSession(String refreshToken);

  Stream<AuthState> get authStateStream;
}
