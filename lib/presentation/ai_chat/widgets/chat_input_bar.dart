import 'package:flutter/material.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSend;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      color: colorScheme.surface,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Tulis pesanmu di sini...',
                filled: true,
                fillColor: colorScheme.surfaceContainerHigh,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
              ),
              onSubmitted: (_) => isLoading ? null : onSend(),
            ),
          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            onPressed: isLoading ? null : onSend,
            shape: const CircleBorder(),
            backgroundColor: isLoading
                ? theme.colorScheme.onSurface.withValues(alpha: 0.12)
                : colorScheme.primary,
            elevation: 2,
            child: Icon(Icons.send, color: colorScheme.onPrimary),
          ),
        ],
      ),
    );
  }
}
