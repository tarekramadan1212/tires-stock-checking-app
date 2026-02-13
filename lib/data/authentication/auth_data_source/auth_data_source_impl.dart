import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supreme/data/authentication/auth_data_source/base_auth_data_source.dart';

class AuthDataSourceImpl implements BaseAuthDataSource{

  final SupabaseClient client;
  AuthDataSourceImpl({required this.client});

  @override
  Stream<AuthState> get authStateStream => client.auth.onAuthStateChange;

  @override
  Future<void> setSession(String refreshToken) async {
    await client.auth.setSession(refreshToken);
  }


  @override
  Future<void> updateProfileCompletion({required Map<String, dynamic> userMetadata, required String password}) async{
    await client.auth.updateUser(UserAttributes(data: userMetadata, password: password));
  }

  @override
  Future<List<Map<String, dynamic>>> getAllBranches() async{
    final List<Map<String, dynamic>> branches = await client.from('branches').select('*');
    return branches;
  }

  @override
  Future<void> signOut() async{
    await client.auth.signOut();
  }

  @override
  Future<void> signInWithPassword({required String email, required String password}) async{
    await client.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> changePassword({required String newPassword}) async{
    await client.auth.updateUser(UserAttributes(password: newPassword));
  }

}