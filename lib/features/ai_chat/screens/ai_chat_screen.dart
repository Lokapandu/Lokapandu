import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  final SupabaseClient _supabase = Supabase.instance.client;

  late final String _userId;

  bool _isLoading = false;
  bool _isFetchingHistory = true;
  final List<ChatMessage> _messages = [];

  bool _isClearing = false;

  @override
  void initState() {
    super.initState();

    final currentUser = _supabase.auth.currentUser;
    if (currentUser == null) {
      if (mounted) context.pop();
      return;
    }
    _userId = currentUser.id;

    _loadChatHistory();
  }

  ChatMessage _getInitialMessage() {
    return const ChatMessage(
      text:
          'Hai! Aku adalah asisten wisatamu. Ada yang bisa aku bantu untuk liburanmu di Bali?',
      isFromUser: false,
    );
  }

  Future<void> _loadChatHistory() async {
    try {
      final response = await _supabase
          .from('chat_messages')
          .select('content, is_from_user')
          .eq('user_id', _userId)
          .order('created_at', ascending: true);

      final loadedMessages = response.map<ChatMessage>((msg) {
        return ChatMessage(
          text: msg['content'],
          isFromUser: msg['is_from_user'],
        );
      }).toList();

      if (loadedMessages.isEmpty) {
        loadedMessages.add(_getInitialMessage());
      }

      if (mounted) {
        setState(() {
          _messages.addAll(loadedMessages);
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _messages.add(
            const ChatMessage(
              text: 'Gagal memuat riwayat chat.',
              isFromUser: false,
            ),
          );
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isFetchingHistory = false;
        });
        _scrollToBottom();
      }
    }
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty || _isLoading || _isClearing) return;

    final userMessageText = _controller.text;
    final userMessage = ChatMessage(text: userMessageText, isFromUser: true);

    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
    });
    _controller.clear();
    _scrollToBottom();

    await _supabase.from('chat_messages').insert({
      'user_id': _userId,
      'content': userMessageText,
      'is_from_user': true,
    });
    try {
      final response = await _supabase.functions.invoke(
        'rekomen-wisata',
        body: {'prompt': userMessageText},
      );

      final aiResponseText =
          response.data['reply'] as String? ?? "Maaf, terjadi kesalahan.";
      final aiMessage = ChatMessage(text: aiResponseText, isFromUser: false);

      setState(() {
        _messages.add(aiMessage);
      });

      await _supabase.from('chat_messages').insert({
        'user_id': _userId,
        'content': aiResponseText,
        'is_from_user': false,
      });
    } catch (e, s) {
      print('--- KESALAHAN PADA AI CHAT (Memanggil Edge Function) ---');
      print('ERROR: $e');
      print('STACK TRACE: $s');
      print('---------------------------------');

      setState(() {
        _messages.add(
          const ChatMessage(
            text: "Oops! Sepertinya ada masalah. Coba lagi beberapa saat ya.",
            isFromUser: false,
          ),
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      _scrollToBottom();
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

  Future<void> _clearChatHistory() async {
    setState(() {
      _isClearing = true;
    });

    final theme = Theme.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      await _supabase.from('chat_messages').delete().eq('user_id', _userId);

      setState(() {
        _messages.clear();
        _messages.add(_getInitialMessage());
      });

      if (mounted) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: const Text('Riwayat chat berhasil dihapus.'),
            backgroundColor: theme.colorScheme.primary, 
          ),
        );
      }
    } catch (e, s) {
      print('--- KESALAHAN SAAT MENGHAPUS CHAT ---');
      print('ERROR: $e');
      print('STACK TRACE: $s');
      print('---------------------------------');

      if (mounted) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: const Text('Gagal menghapus riwayat chat. Coba lagi.'),
            backgroundColor: theme.colorScheme.error, 
          ),
        );
      }
    } finally {
      setState(() {
        _isClearing = false;
      });
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

    if (_isFetchingHistory) {
      return Scaffold(
        appBar: AppBar(
          title: Text('AI Chat', style: theme.textTheme.titleLarge),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text('AI Chat', style: theme.textTheme.titleLarge),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _isClearing ? null : _showClearConfirmationDialog,
            tooltip: 'Hapus Riwayat Chat',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(
                  text: message.text,
                  isFromUser: message.isFromUser,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 12),
            ),
          ),
          if (_isLoading)
            Padding(
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
            ),
          _buildMessageInput(theme, colorScheme),
        ],
      ),
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
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            onPressed: _isLoading || _isClearing ? null : _sendMessage,
            backgroundColor: _isLoading || _isClearing
                ? theme.colorScheme.onSurface.withOpacity(0.12)
                : colorScheme.primary,
            elevation: 2,
            child: Icon(Icons.send, color: colorScheme.onPrimary),
          ),
        ],
      ),
    );
  }
}
