import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/presentation/auth/widgets/sign_in_error_message.dart';
import 'package:provider/provider.dart';
import 'package:lokapandu/common/services/firebase_analytics_service.dart';
import 'package:lokapandu/presentation/auth/providers/auth_provider.dart';
import 'package:lokapandu/common/utils/error_message_helper.dart';

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
    return Scaffold(
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
                  SvgPicture.asset(
                    'assets/icons/A day off-pana.svg',
                    height: 250,
                  ),

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
                    SignInErrorMessage(
                      message: ErrorMessageHelper.getReadableErrorMessage(
                        authNotifier.errorMessage,
                      ),
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
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.black54,
                              ),
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

                            final success = await authNotifier
                                .signInWithGoogle();
                            if (success && context.mounted) {
                              context.goNamed('tourism_spot');
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
                      text:
                          'Dengan mendaftarkan akun, saya setuju dengan seluruh ',
                      style: Theme.of(context).textTheme.bodySmall,
                      children: [
                        TextSpan(
                          text: 'Syarat dan Ketentuan yang berlaku',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
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
    );
  }
}
