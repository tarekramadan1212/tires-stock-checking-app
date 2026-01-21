import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseAuthDataSource{

  Future<void> setSession(String refreshToken);
  Stream<AuthState> get authStateStream;
  Future<List<Map<String, dynamic>>> getAllBranches();
  Future<void> updateProfileCompletion({required Map<String, dynamic> userMetadata, required String password});
  Future<void> signInWithPassword({required String email, required String password});
  Future<void> signOut();

}