import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'auth_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/LokaPandu.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Lokapandu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(blurRadius: 8.0, color: Colors.black45)],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 25, left: 15, right: 15),
              child: _buildGlassmorphicCard(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassmorphicCard(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(10, 15, 20, 42),
          decoration: BoxDecoration(
            color: Colors.teal.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(45)),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center, // Pastikan ini start
            children: [
              const Text(
                'Mulai Sekarang',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Jelajahi dunia dengan Lokapandu sebagai pemandu andalanmu, sekarang!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: SvgPicture.asset(
                  'assets/icons/google_logo.svg',
                  height: 22.0,
                ),
                label: const Text(
                  'Masuk dengan Google',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                //  LOGIKA NAVIGASI
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black.withOpacity(0.8),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  elevation: 2,
                  shadowColor: Colors.black.withOpacity(0.1),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text.rich(
                  TextSpan(
                    text:
                        'Dengan mendaftarkan akun, saya setuju dengan seluruh\n',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                    children: const [
                      TextSpan(
                        text: 'Syarat dan Ketentuan yang berlaku',
                        style: TextStyle(
                          color: Color(0xFF07AEAF),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFF6AF2F0),
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
