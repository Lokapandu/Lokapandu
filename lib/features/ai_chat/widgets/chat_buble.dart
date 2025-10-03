import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isFromUser;

  const ChatBubble({super.key, required this.text, required this.isFromUser});

  @override
  Widget build(BuildContext context) {
    // Ambil theme dan colorScheme dari context
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Menentukan alignment (tidak perlu diubah)
    final alignment = isFromUser
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    // --- PERUBAHAN UTAMA ADA DI SINI ---

    // 1. Mengambil warna bubble dari theme
    final color = isFromUser ? colorScheme.primary : colorScheme.outlineVariant;

    // 2. Mengambil warna teks dari theme
    final textColor = isFromUser
        ? colorScheme.onPrimary
        : colorScheme.onSurface;

    // ------------------------------------

    // Bentuk sudut bubble (tidak perlu diubah)
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
          child: Text(
            text,
            // 3. Menerapkan style teks dari theme
            style: theme.textTheme.bodyLarge?.copyWith(
              color: textColor,
              height: 1.4, // Line spacing bisa tetap jika diinginkan
            ),
          ),
        ),
      ],
    );
  }
}
