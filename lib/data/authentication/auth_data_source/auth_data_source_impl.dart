import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supreme/data/authentication/auth_data_source/base_auth_data_source.dart';
import 'package:supreme/data/authentication/models/userdata_model.dart';

class AuthDataSourceImpl implements BaseAuthDataSource {
  final SupabaseClient client;

  AuthDataSourceImpl({required this.client});

  @override
  Stream<AuthState> get authStateStream => client.auth.onAuthStateChange;

  @override
  Future<void> setSession(String refreshToken) async {
    await client.auth.setSession(refreshToken);
  }

  @override
  Future<void> updateProfileCompletion({
    required Map<String, dynamic> userMetadata,
    required String password,
  }) async {
    await client.auth.updateUser(
      UserAttributes(data: userMetadata, password: password),
    );
    await client
        .from('profiles')
        .update({'branch_id': userMetadata['branch_id']})
        .eq('id', client.auth.currentUser!.id);
  }

  @override
  Future<List<Map<String, dynamic>>> getAllBranches() async {
    final List<Map<String, dynamic>> branches = await client
        .from('branches')
        .select('*');
    return branches;
  }

  @override
  Future<void> signOut() async {
    await client.auth.signOut();
  }

  @override
  Future<void> signInWithPassword({
    required String email,
    required String password,
  }) async {
    await client.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> changePassword({required String newPassword}) async {
    await client.auth.updateUser(UserAttributes(password: newPassword));
  }

  @override
  Future<void> forgetPassword({required String email}) async {
    await client.auth.resetPasswordForEmail(
      email,
      redirectTo: 'io.supabase.supreme://reset-callback/',
    );
  }

  @override
  Future<UserDataModel> getUserData() async {
    final user = client.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    } else {
      final metadata = user.userMetadata ?? {};
      return UserDataModel(
        email: user.email,
        isVerified: user.emailConfirmedAt != null,
        branchId: metadata['branch_id'],
        branchName: metadata['branch_name'],
        userId: user.id,
      );
    }
  }
}
