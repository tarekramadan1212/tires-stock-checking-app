import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supreme/core/utilities/netwrok/failures.dart';
import 'package:supreme/data/authentication/auth_data_source/base_auth_data_source.dart';
import 'package:supreme/data/authentication/auth_repo/base_auth_repo.dart';
import 'package:supreme/data/authentication/models/branch_model.dart';

class AuthRepositoryImpl implements BaseAuthRepository {
  final BaseAuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Stream<AuthState> get authStateStream => authDataSource.authStateStream;

  @override
  Future<Either<CustomFailure, List<BranchModel>>> fetchBranches() async {
    try {
      final branches = await authDataSource.getAllBranches();
      return Right(
        branches
            .map(
              (element) =>
                  BranchModel(name: element['name'], id: element['id']),
            )
            .toList(),
      );

    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException catch (e) {
      return Left(NetworkFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<CustomFailure, Unit>> setSession(String refreshToken) async {
    try {
      await authDataSource.setSession(refreshToken);
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on SocketException catch (e) {
      return Left(NetworkFailure(e.message));
    }catch (e){
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<CustomFailure, Unit>> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      await authDataSource.signInWithPassword(email: email, password: password);
      return  Right(unit);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on SocketException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<CustomFailure, Unit>> signOut() async {
    try{
      await authDataSource.signOut();
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on SocketException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<CustomFailure, Unit>> updateProfileCompletion({
    required Map<String, dynamic> userMetadata,
    required String password,
  }) async {
    try {
      await authDataSource.updateProfileCompletion(userMetadata: userMetadata, password: password);
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on SocketException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }
}
