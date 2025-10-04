import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as developer;

/// Service class that handles authentication operations with Google Sign-In and Supabase
class AuthService {
  // static const _androidClientId = '815598506761-g2b0qgus8j9dpmild7ji1n493qneifdf.apps.googleusercontent.com';
  // static const _iosClientId = '815598506761-ho0ck3e9k89r8v5eutsg1mvhg2o6raup.apps.googleusercontent.com';
  final _scopes = ['email', 'profile'];
  final SupabaseClient _supabaseClient;
  final GoogleSignIn _googleSignIn;

  AuthService({required GoogleSignIn googleSignIn})
    : _googleSignIn = googleSignIn,
      _supabaseClient = Supabase.instance.client;

  /// Get current user from Supabase
  User? get currentUser => _supabaseClient.auth.currentUser;

  /// Check if user is currently signed in
  bool get isSignedIn => currentUser != null;

  /// Stream of auth state changes
  Stream<AuthState> get authStateChanges =>
      _supabaseClient.auth.onAuthStateChange;

  /// Sign in with Google using Supabase Auth
  Future<AuthResponse> signInWithGoogle() async {
    try {
      developer.log('Starting Google Sign-In process', name: 'AuthService');
      await _googleSignIn.initialize();
      // Step 1: Sign in with Google
      final googleUser = await _googleSignIn.attemptLightweightAuthentication();

      if (googleUser == null) {
        throw AuthException('Google Sign-In was cancelled by user');
      }

      developer.log(
        'Google Sign-In successful for: ${googleUser.email}',
        name: 'AuthService',
      );

      // Step 2: Get Google authorization code
      final authorization =
          await googleUser.authorizationClient.authorizationForScopes(
            _scopes,
          ) ??
          await googleUser.authorizationClient.authorizeScopes(_scopes);

      final idToken = googleUser.authentication.idToken;

      if (idToken == null) {
        throw AuthException('Failed to obtain Google ID token');
      }

      developer.log('Google ID token obtained', name: 'AuthService');

      // Step 3: Sign in to Supabase with Google ID token
      final AuthResponse response = await _supabaseClient.auth
          .signInWithIdToken(
            provider: OAuthProvider.google,
            idToken: idToken,
            accessToken: authorization.accessToken,
          );

      if (response.user == null) {
        throw AuthException('Failed to authenticate with Supabase');
      }

      developer.log(
        'Supabase authentication successful for user: ${response.user!.email}',
        name: 'AuthService',
      );

      return response;
    } on AuthException {
      rethrow;
    } catch (e) {
      developer.log('Google Sign-In error: $e', name: 'AuthService');
      throw AuthException('Failed to sign in with Google: $e');
    }
  }

  /// Sign out from both Google and Supabase
  Future<void> signOut() async {
    try {
      developer.log('Starting sign out process', name: 'AuthService');

      // Sign out from Supabase
      await _supabaseClient.auth.signOut();

      // Sign out from Google
      await _googleSignIn.signOut();

      developer.log('Sign out successful', name: 'AuthService');
    } catch (e) {
      developer.log('Sign out error: $e', name: 'AuthService');
      throw AuthException('Failed to sign out: $e');
    }
  }

  /// Get user profile information
  Map<String, dynamic>? get userProfile {
    final user = currentUser;
    if (user == null) return null;

    return {
      'id': user.id,
      'email': user.email,
      'name': user.userMetadata?['full_name'] ?? user.userMetadata?['name'],
      'avatar_url':
          user.userMetadata?['avatar_url'] ?? user.userMetadata?['picture'],
      'provider': user.appMetadata['provider'],
    };
  }

  /// Dispose resources
  void dispose() {
    // Clean up if needed
  }
}
