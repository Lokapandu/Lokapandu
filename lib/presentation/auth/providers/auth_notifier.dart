import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:lokapandu/common/services/analytics_manager.dart';
import 'package:lokapandu/data/datasources/services/auth_service.dart';

/// Authentication state enum
enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

/// AuthNotifier handles authentication state management using Provider pattern
class AuthNotifier extends ChangeNotifier {
  final AuthService _authService;
  final AnalyticsManager _analyticsManager;

  AuthStatus _status = AuthStatus.initial;
  String? _errorMessage;
  User? _user;
  StreamSubscription<AuthState>? _authSubscription;

  AuthNotifier({
    required AuthService authService,
    required AnalyticsManager analyticsManager,
  }) : _authService = authService,
       _analyticsManager = analyticsManager {
    _initializeAuth();
  }

  // Getters
  AuthStatus get status => _status;
  String? get errorMessage => _errorMessage;
  User? get user => _user;
  bool get isAuthenticated =>
      _status == AuthStatus.authenticated && _user != null;
  bool get isLoading => _status == AuthStatus.loading;

  /// Initialize authentication state and listen to auth changes
  void _initializeAuth() {
    developer.log('Initializing auth state', name: 'AuthNotifier');

    // Set initial user state
    _user = _authService.currentUser;
    _status = _user != null
        ? AuthStatus.authenticated
        : AuthStatus.unauthenticated;

    // Listen to auth state changes
    _authSubscription = _authService.authStateChanges.listen(
      (AuthState authState) {
        developer.log(
          'Auth state changed: ${authState.event}',
          name: 'AuthNotifier',
        );
        _handleAuthStateChange(authState);
      },
      onError: (error) {
        developer.log('Auth state error: $error', name: 'AuthNotifier');
        _setError('Authentication error: $error');
      },
    );

    notifyListeners();
  }

  /// Handle auth state changes from Supabase
  void _handleAuthStateChange(AuthState authState) {
    switch (authState.event) {
      case AuthChangeEvent.signedIn:
        _user = authState.session?.user;
        _status = AuthStatus.authenticated;
        _errorMessage = null;
        developer.log('User signed in: ${_user?.email}', name: 'AuthNotifier');
        break;
      case AuthChangeEvent.signedOut:
        _user = null;
        _status = AuthStatus.unauthenticated;
        _errorMessage = null;
        developer.log('User signed out', name: 'AuthNotifier');
        break;
      case AuthChangeEvent.tokenRefreshed:
        _user = authState.session?.user;
        developer.log(
          'Token refreshed for user: ${_user?.email}',
          name: 'AuthNotifier',
        );
        break;
      default:
        break;
    }
    notifyListeners();
  }

  /// Sign in with Google
  Future<bool> signInWithGoogle() async {
    try {
      _setLoading();

      developer.log('Starting Google Sign-In', name: 'AuthNotifier');

      // Track analytics event
      await _analyticsManager.trackUserAction(
        action: 'google_sign_in_attempt',
        parameters: {
          'screen': 'auth',
          'method': 'google',
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      await _analyticsManager.startTrace('google_sign_in');
      final response = await _authService.signInWithGoogle();
      await _analyticsManager.stopTrace('google_sign_in');

      if (response.user != null) {
        // Track successful sign-in
        await _analyticsManager.trackUserAction(
          action: 'google_sign_in_success',
          parameters: {
            'screen': 'auth',
            'user_id': response.user!.id,
            'email': response.user!.email,
            'providers': 'google',
          },
        );

        // Track login event
        await _analyticsManager.trackEvent(
          eventName: 'login',
          parameters: {
            'method': 'google',
            'user_id': response.user!.id,
            'success': 'true',
            'timestamp': DateTime.now().toIso8601String(),
          },
        );

        // Set user ID for analytics
        await _analyticsManager.setUserId(response.user!.id);

        developer.log('Google Sign-In successful', name: 'AuthNotifier');
        return true;
      } else {
        throw Exception('No user returned from sign-in');
      }
    } catch (e) {
      developer.log('Google Sign-In failed: $e', name: 'AuthNotifier');

      // Track failed sign-in
      await _analyticsManager.trackUserAction(
        action: 'google_sign_in_failed',
        parameters: {
          'screen': 'auth',
          'error': e.toString(),
          'method': 'google',
        },
      );

      _setError('Failed to sign in with Google: $e');
      return false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      _setLoading();

      developer.log('Starting sign out', name: 'AuthNotifier');

      // Track logout event
      await _analyticsManager.trackEvent(
        eventName: 'logout',
        parameters: {'timestamp': DateTime.now().toIso8601String()},
      );

      await _analyticsManager.startTrace('sign_out');
      await _authService.signOut();
      await _analyticsManager.stopTrace('sign_out');

      developer.log('Sign out successful', name: 'AuthNotifier');
    } catch (e) {
      developer.log('Sign out failed: $e', name: 'AuthNotifier');
      _setError('Failed to sign out: $e');
    }
  }

  /// Get user profile information
  Map<String, dynamic>? get userProfile => _authService.userProfile;

  /// Set loading state
  void _setLoading() {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }

  /// Set error state
  void _setError(String message) {
    _status = AuthStatus.error;
    _errorMessage = message;
    notifyListeners();
  }

  /// Clear error
  void clearError() {
    if (_status == AuthStatus.error) {
      _status = _user != null
          ? AuthStatus.authenticated
          : AuthStatus.unauthenticated;
      _errorMessage = null;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    _authService.dispose();
    super.dispose();
  }
}
