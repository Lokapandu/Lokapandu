import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'package:lokapandu/presentation/settings/providers/package_info_notifier.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Fade animation controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Slide animation controller
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    // Slide animation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/LokaPandu.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Darker overlay for better text readability
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.5),
                  Colors.black.withValues(alpha: 0.7),
                  Colors.black.withValues(alpha: 0.8),
                ],
              ),
            ),
          ),

          // App bar with back button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Spacer(),
                  AnimatedBuilder(
                    animation: _fadeAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _fadeAnimation.value,
                        child: Text(
                          'About',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 8.0,
                                    color: Colors.black.withValues(alpha: 0.7),
                                  ),
                                ],
                              ),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  const SizedBox(width: 48), // Balance the back button
                ],
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 80.0,
              ),
              child: Column(
                children: [
                  const Spacer(),

                  // App logo and title section
                  AnimatedBuilder(
                    animation: _fadeAnimation,
                    builder: (context, child) {
                      return SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Consumer<PackageInfoNotifier>(
                            builder: (context, packageInfo, child) {
                              return Column(
                                children: [
                                  // App title
                                  Text(
                                    'Lokapandu',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 36,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 12.0,
                                              color: Colors.black.withValues(
                                                alpha: 0.8,
                                              ),
                                            ),
                                          ],
                                        ),
                                    textAlign: TextAlign.center,
                                  ),

                                  const SizedBox(height: 12),

                                  // Version
                                  Text(
                                    'Version ${packageInfo.packageInfo?.version ?? '1.0.0-dev'}',
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: Colors.white.withValues(
                                            alpha: 0.8,
                                          ),
                                          fontSize: 18,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 6.0,
                                              color: Colors.black.withValues(
                                                alpha: 0.6,
                                              ),
                                            ),
                                          ],
                                        ),
                                    textAlign: TextAlign.center,
                                  ),

                                  const SizedBox(height: 32),

                                  // Description
                                  Container(
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(
                                        alpha: 0.3,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: Colors.white.withValues(
                                          alpha: 0.2,
                                        ),
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Aplikasi sederhana dan intuitif yang dirancang untuk membantu Anda menjelajahi keindahan wisata lokal dengan panduan yang terpercaya.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: Colors.white.withValues(
                                                  alpha: 0.9,
                                                ),
                                                fontSize: 16,
                                                height: 1.6,
                                                shadows: [
                                                  Shadow(
                                                    blurRadius: 4.0,
                                                    color: Colors.black
                                                        .withValues(alpha: 0.5),
                                                  ),
                                                ],
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Kami adalah lokapandu:',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: Colors.white.withValues(
                                                  alpha: 0.9,
                                                ),
                                                fontSize: 16,
                                                height: 1.6,
                                                shadows: [
                                                  Shadow(
                                                    blurRadius: 4.0,
                                                    color: Colors.black
                                                        .withValues(alpha: 0.5),
                                                  ),
                                                ],
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 4),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 4,
                                            ),
                                            child: Text(
                                              ' BC25B020 - Ilham Muchammad Reza \n'
                                              ' BC25B050 - I Gusti Ayu Krisna Kusuma Dewi \n'
                                              ' BC25B061 - Yusuf Saputrah \n'
                                              ' BC25B080 - Andi Irham Marhamuddin - Flutter \n',
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: Colors.white
                                                        .withValues(alpha: 0.9),
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius: 4.0,
                                                        color: Colors.black
                                                            .withValues(
                                                              alpha: 0.5,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),

                  const Spacer(),

                  // Footer section
                  AnimatedBuilder(
                    animation: _fadeAnimation,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Dibuat dengan ❤️ oleh Tim B25-PG008',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.white.withValues(
                                            alpha: 0.9,
                                          ),
                                          fontSize: 15,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 4.0,
                                              color: Colors.black.withValues(
                                                alpha: 0.6,
                                              ),
                                            ),
                                          ],
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '© ${DateTime.now().year} Lokapandu',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: Colors.white.withValues(
                                            alpha: 0.7,
                                          ),
                                          fontSize: 14,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 4.0,
                                              color: Colors.black.withValues(
                                                alpha: 0.6,
                                              ),
                                            ),
                                          ],
                                        ),
                                    textAlign: TextAlign.center,
                                  ),

                                  Consumer<PackageInfoNotifier>(
                                    builder:
                                        (context, packageInfoNotifier, child) {
                                          final PackageInfo? info =
                                              packageInfoNotifier.packageInfo;
                                          return FilledButton(
                                            onPressed: () {
                                              showLicensePage(
                                                context: context,
                                                applicationName: "Lokapandu",
                                                applicationVersion:
                                                    info?.version,
                                                applicationLegalese:
                                                    'MIT License',
                                              );
                                            },
                                            child: Text('Lisensi'),
                                          );
                                        },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
