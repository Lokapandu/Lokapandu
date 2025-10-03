import 'dart:async';

import 'package:flutter/material.dart';

class SignInErrorMessage extends StatefulWidget {
  final String message;
  final VoidCallback onDismiss;

  const SignInErrorMessage({
    super.key,
    required this.message,
    required this.onDismiss,
  });

  @override
  State<SignInErrorMessage> createState() => _SignInErrorMessageState();
}

class _SignInErrorMessageState extends State<SignInErrorMessage>
    with TickerProviderStateMixin {
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

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

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
                  Icon(Icons.close, color: Colors.red.shade400, size: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
