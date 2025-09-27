import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isFromUser;

  const ChatBubble({super.key, required this.text, required this.isFromUser});

  @override
  Widget build(BuildContext context) {
    // Menentukan alignment dan warna berdasarkan pengirim
    final alignment = isFromUser
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final color = isFromUser ? const Color(0xFF008080) : Colors.grey[200];
    final textColor = isFromUser ? Colors.white : Colors.black87;
    final borderRadius = isFromUser
        ? const BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          );

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(color: color, borderRadius: borderRadius),
          child: Text(text, style: TextStyle(color: textColor, height: 1.4)),
        ),
      ],
    );
  }
}
