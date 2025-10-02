import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:lokapandu/common/services/firebase_analytics_service.dart';
import 'package:lokapandu/presentation/auth/providers/auth_provider.dart';
import 'package:lokapandu/common/utils/error_message_helper.dart';
import 'package:lokapandu/injection.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
    
    // Track auth screen page view
    FirebaseAnalyticsService().trackPageView(
      screenName: 'auth',
      screenClass: 'AuthScreen',
      parameters: {
        'entry_time': DateTime.now().toIso8601String(),
        'source': 'splash_screen',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthNotifier>(
      create: (_) => locator<AuthNotifier>(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Consumer<AuthNotifier>(
              builder: (context, authNotifier, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                'Lokapandu',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),

              const SizedBox(height: 40),
              SvgPicture.asset('assets/icons/A day off-pana.svg', height: 250),

              const SizedBox(height: 40),

              Text(
                'Ayo, mulai perjalanan kita!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: 16),

              Text(
                'Segera masuk menggunakan akun Google mu di bawah ini untuk memulai perjalanan!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),

              const SizedBox(height: 32),

              // Error Display - Simple dismissible message
              if (authNotifier.errorMessage != null) ...[
                _ErrorMessage(
                  message: ErrorMessageHelper.getReadableErrorMessage(authNotifier.errorMessage),
                  onDismiss: () => authNotifier.clearError(),
                ),
              ],

              //Tombol Masuk dengan Google
              ElevatedButton.icon(
                icon: authNotifier.status == AuthStatus.loading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
                        ),
                      )
                    : SvgPicture.asset(
                        'assets/icons/google_logo.svg',
                        height: 24.0,
                      ),
                label: Text(
                  authNotifier.status == AuthStatus.loading 
                      ? 'Masuk...' 
                      : 'Masuk dengan Google',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: authNotifier.status == AuthStatus.loading 
                    ? null 
                    : () async {
                        // Clear any previous errors
                        if (authNotifier.status == AuthStatus.error) {
                          authNotifier.clearError();
                        }
                        
                        final success = await authNotifier.signInWithGoogle();
                        if (success && context.mounted) {
                          context.go('/tourism-spot');
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black.withValues(alpha: .8),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  elevation: 2,
                  shadowColor: Colors.black.withValues(alpha: .1),
                ),
              ),

              const Spacer(flex: 3),

              Text.rich(
                TextSpan(
                  text: 'Dengan mendaftarkan akun, saya setuju dengan seluruh ',
                  style: Theme.of(context).textTheme.bodySmall,
                  children: [
                    TextSpan(
                      text: 'Syarat dan Ketentuan yang berlaku',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorMessage extends StatefulWidget {
  final String message;
  final VoidCallback onDismiss;

  const _ErrorMessage({
    required this.message,
    required this.onDismiss,
  });

  @override
  State<_ErrorMessage> createState() => _ErrorMessageState();
}

class _ErrorMessageState extends State<_ErrorMessage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _autoHideTimer;

  @override
  void initState() {
    super.initState();
    
    // Setup animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    // Start fade in animation
    _animationController.forward();
    
    // Auto hide after 4 seconds
    _autoHideTimer = Timer(const Duration(seconds: 4), () {
      _dismissError();
    });
  }

  @override
  void dispose() {
    _autoHideTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _dismissError() async {
    _autoHideTimer?.cancel();
    await _animationController.reverse();
    if (mounted) {
      widget.onDismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: GestureDetector(
            onTap: _dismissError,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red.shade600,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.close,
                    color: Colors.red.shade400,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
