import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/presentation/ai_chat/provider/ai_chat_notifier.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/chat_message_model.dart';
import '../widgets/chat_buble.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _showClearConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Riwayat Chat?'),
        content: const Text(
          'Semua riwayat percakapan Anda akan dihapus secara permanen. Tindakan ini tidak dapat dibatalkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              context.pop();
              _clearChatHistory();
            },
            child: Text(
              'Hapus',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _clearChatHistory() async {
    final theme = Theme.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      await context.read<AiChatNotifier>().clearChatHistory();

      if (mounted) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: const Text('Riwayat chat berhasil dihapus.'),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
      }
    } catch (e, s) {
      if (mounted) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: const Text('Gagal menghapus riwayat chat. Coba lagi.'),
            backgroundColor: theme.colorScheme.error,
          ),
        );
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // if (_isFetchingHistory) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: Text('AI Chat', style: theme.textTheme.titleLarge),
    //     ),
    //     body: const Center(child: CircularProgressIndicator()),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text('AI Chat', style: theme.textTheme.titleLarge),
        centerTitle: true,
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.delete_outline),
          //   onPressed: _isClearing ? null : _showClearConfirmationDialog,
          //   tooltip: 'Hapus Riwayat Chat',
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: context.read<AiChatNotifier>().chatsStream,
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2.5),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'AI sedang berpikir...',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final messages = snapshot.data ?? [];
            return ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ChatBubble(
                  text: message.text,
                  isFromUser: message.isFromUser,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 12),
            );
          },
        ),
      ),
      bottomNavigationBar: _buildMessageInput(theme, colorScheme),
    );
  }

  Widget _buildMessageInput(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      color: colorScheme.surface,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Tulis pesanmu di sini...',
                filled: true,
                fillColor: colorScheme.surfaceContainerHigh,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => context.read<AiChatNotifier>().sendMessage,
            ),
          ),
          const SizedBox(width: 12),
          Consumer<AiChatNotifier>(
            builder: (context, notifier, child) => FloatingActionButton(
              onPressed: notifier.isLoading || notifier.hasError
                  ? null
                  : () => notifier.sendMessage(_controller.text),
              backgroundColor: notifier.isLoading || notifier.hasError
                  ? theme.colorScheme.onSurface.withValues(alpha: 0.12)
                  : colorScheme.primary,
              elevation: 2,
              child: Icon(Icons.send, color: colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
