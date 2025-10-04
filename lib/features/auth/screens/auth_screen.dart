/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lokapandu/features/home/screens/home_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF7FAFA,
      ), // Warna latar belakang agak off-white
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),

              const Text(
                'Lokapandu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF008080),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),
              SvgPicture.asset('assets/icons/A day off-pana.svg', height: 250),

              const SizedBox(height: 40),

              const Text(
                'Ayo, mulai perjalanan kita!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Segera masuk menggunakan akun Google mu di bawah ini untuk memulai perjalanan!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              //Tombol Masuk dengan Google
              ElevatedButton.icon(
                icon: SvgPicture.asset(
                  'assets/icons/google_logo.svg',
                  height: 22.0,
                ),
                label: const Text(
                  'Masuk dengan Google',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black.withOpacity(0.8),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  elevation: 2,
                  shadowColor: Colors.black.withOpacity(0.1),
                ),
              ),

              const Spacer(flex: 3),

              Text.rich(
                TextSpan(
                  text: 'Dengan mendaftarkan akun, saya setuju dengan seluruh ',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  children: const [
                    TextSpan(
                      text: 'Syarat dan Ketentuan yang berlaku',
                      style: TextStyle(
                        color: Color(0xFF008080),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
*/
