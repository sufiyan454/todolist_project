import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  User? get currentUser => supabase.auth.currentUser;

  Future<void> signUp(String email, String password, String name) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );
    if (response.user == null) {
      throw Exception('Sign up failed. Please try again.');
    }
  }

  Future<void> login(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.user == null) {
      throw Exception('Login failed. Check your credentials.');
    }
  }

  Future<void> googleLogin() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.todoproject://login-callback/',
    );
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  String get userName {
    final meta = currentUser?.userMetadata;
    return meta?['name'] ?? currentUser?.email?.split('@').first ?? 'User';
  }
}
