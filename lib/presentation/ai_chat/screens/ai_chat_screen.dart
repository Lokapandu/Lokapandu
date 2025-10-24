import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/presentation/ai_chat/provider/ai_chat_notifier.dart';
import 'package:lokapandu/presentation/ai_chat/widgets/chat_input_bar.dart';
import 'package:lokapandu/presentation/plan/utils/snackbar_util.dart';
import 'package:provider/provider.dart';

import '../widgets/chat_buble.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final notifier = context.read<AiChatNotifier>();

    // Add listener untuk auto-scroll ketika ada perubahan data
    notifier.addListener(_onChatDataChanged);

    Future.microtask(() {
      notifier.loadChatHistory();
      notifier.initStream();
    });
  }

  void _onChatDataChanged() {
    final notifier = context.read<AiChatNotifier>();
    if (notifier.chats.isNotEmpty) {
      _scrollDown();
    }
  }

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

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
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
          snackbar('Riwayat chat berhasil dihapus.', backgroundColor: theme.colorScheme.primary),
        );
      }
    } catch (e) {
      if (mounted) {
        scaffoldMessenger.showSnackBar(
          snackbar(
            'Gagal menghapus riwayat chat. Coba lagi.',
            backgroundColor: theme.colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // Remove listener untuk mencegah memory leak
    final notifier = context.read<AiChatNotifier>();
    notifier.removeListener(_onChatDataChanged);

    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text('AI Chat', style: theme.textTheme.titleLarge),
        centerTitle: true,
        actions: [
          Consumer<AiChatNotifier>(
            builder: (context, notifier, child) {
              return IconButton(
                icon: notifier.isClearing
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            theme.colorScheme.onSurface,
                          ),
                        ),
                      )
                    : const Icon(Icons.delete_outline),
                onPressed: notifier.isClearing
                    ? null
                    : _showClearConfirmationDialog,
                tooltip: notifier.isClearing
                    ? 'Menghapus riwayat...'
                    : 'Hapus Riwayat Chat',
              );
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Consumer<AiChatNotifier>(
          builder: (context, notifier, child) {
            final messages = notifier.chats;

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
      bottomNavigationBar: Selector<AiChatNotifier, bool>(
        selector: (context, notifier) => notifier.isLoading,
        builder: (context, isLoading, child) {
          return ChatInputBar(
            controller: _controller,
            isLoading: isLoading,
            onSend: () {
              if (_controller.text.isNotEmpty) {
                final userMessage = _controller.text;
                _controller.clear();
                FocusScope.of(context).unfocus();

                // Panggil logic di Provider
                context.read<AiChatNotifier>().sendMessage(userMessage);
              }
            },
          );
        },
      ),
    );
  }
}
