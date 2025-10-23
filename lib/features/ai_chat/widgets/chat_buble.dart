import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isFromUser;

  const ChatBubble({super.key, required this.text, required this.isFromUser});

  @override
  Widget build(BuildContext context) {
   
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final alignment = isFromUser
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    final color = isFromUser ? colorScheme.primary : colorScheme.outlineVariant;

    final textColor = isFromUser
        ? colorScheme.onPrimary
        : colorScheme.onSurface;

   
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
          
            style: theme.textTheme.bodyLarge?.copyWith(
              color: textColor,
              height: 1.4, 
            ),
          ),
        ),
      ],
    );
  }
}
