import 'package:flutter/material.dart';
import 'package:lokapandu/presentation/ai_chat/provider/ai_chat_notifier.dart';
import 'package:provider/provider.dart';

class ClearChatButton extends StatelessWidget {
  const ClearChatButton({super.key});

  void _showClearConfirmationDialog(BuildContext context) {
    final notifier = context.read<AiChatNotifier>();
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Riwayat Chat?'),
        content: const Text(
          'Semua riwayat percakapan Anda akan dihapus secara permanen.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              final bool success = await notifier.clearChatHistory();

              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    success
                        ? 'Riwayat chat berhasil dihapus.'
                        : 'Gagal menghapus riwayat chat.',
                  ),

                  backgroundColor: success
                      ? theme.colorScheme.primary
                      : theme.colorScheme.error,
                ),
              );
            },
            child: Text(
              'Hapus',
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isClearing = context.watch<AiChatNotifier>().isClearing;

    return IconButton(
      icon: const Icon(Icons.delete_outline),
      onPressed: isClearing
          ? null
          : () => _showClearConfirmationDialog(context),
      tooltip: 'Hapus Riwayat Chat',
    );
  }
}
