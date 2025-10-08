import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/routes/routing_list.dart';
import 'package:lokapandu/common/services/firebase_analytics_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _textController;
  late Animation<double> _backgroundAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Track splash screen page view
    FirebaseAnalyticsService().trackPageView(
      screenName: 'splash',
      screenClass: 'SplashScreen',
      parameters: {'entry_time': DateTime.now().toIso8601String()},
    );

    // Background zoom animation controller
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Text animation controller
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Background zoom animation (1.0 to 1.2 scale)
    _backgroundAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _backgroundController, curve: Curves.easeInOut),
    );

    // Text fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    // Text slide animation
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _textController,
            curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
          ),
        );

    // Start animations
    _startAnimations();
  }

  void _startAnimations() async {
    final startTime = DateTime.now();

    // Track animation start
    FirebaseAnalyticsService().trackEvent(
      eventName: 'animation_started',
      parameters: {'animation_type': 'background_zoom', 'screen': 'splash'},
    );

    // Start background zoom
    _backgroundController.forward();

    // Start text animations after a short delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Track text animation start
    FirebaseAnalyticsService().trackEvent(
      eventName: 'animation_started',
      parameters: {
        'animation_type': 'text_fade_slide',
        'delay_ms': 500,
        'screen': 'splash',
      },
    );

    _textController.forward();

    // Navigate to auth screen after animations complete
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      // Track total splash screen duration
      final totalDuration = DateTime.now().difference(startTime);
      FirebaseAnalyticsService().trackTiming(
        category: 'splash_screen',
        variable: 'duration',
        timeInMs: totalDuration.inMilliseconds,
      );

      // Track navigation event
      FirebaseAnalyticsService().trackNavigation(
        destination: 'auth',
        source: 'splash',
        method: 'auto_redirect',
        parameters: {'total_splash_time_ms': totalDuration.inMilliseconds},
      );

      // Track user action
      FirebaseAnalyticsService().trackUserAction(
        action: 'navigate_to_auth',
        category: 'navigation',
        parameters: {
          'trigger': 'automatic',
          'after_animations': 1,
          'screen': 'splash',
        },
      );

      final user = Supabase.instance.client.auth.currentUser;
      final isLoggedIn = user != null;

      if (isLoggedIn) {
        context.pushReplacementNamed(Routing.home.routeName);
      } else {
        context.pushReplacementNamed(Routing.auth.routeName);
      }
    }
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background
          AnimatedBuilder(
            animation: _backgroundAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _backgroundAnimation.value,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/LokaPandu.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),

          // Dark overlay for better text readability
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),

          // App title at top
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _fadeAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _fadeAnimation.value,
                        child: Text(
                          'Lokapandu',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 8.0,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Welcome message at bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 80, left: 30, right: 30),
              child: AnimatedBuilder(
                animation: _textController,
                builder: (context, child) {
                  return SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildWelcomeMessage(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Selamat Datang',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Jelajahi dunia dengan Lokapandu\nsebagai pemandu andalanmu',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
            shadows: const [Shadow(blurRadius: 6.0, color: Colors.black54)],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        // Loading indicator
        const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2,
          ),
        ),
      ],
    );
  }
}
