import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter untuk navigasi
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
  final List<ChatMessage> _messages = [
    const ChatMessage(
      text: 'Hai, Ayu Krisna! Ada yang bisa aku bantu di Bali sore ini?',
      isFromUser: false,
    ),
    const ChatMessage(
      text: 'AI, saranin aku tempat wisata, dong!',
      isFromUser: true,
    ),
    const ChatMessage(
      text:
          'Tentu! Kamu tertarik dengan jenis wisata apa? Pantai, budaya, atau alam pegunungan?',
      isFromUser: false,
    ),
  ];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(text: _controller.text, isFromUser: true));
      });
      _controller.clear();
      _scrollToBottom();

      // Simulasi balasan AI
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _messages.add(
            const ChatMessage(
              text: "Ini balasan AI untuk pesanmu 😄",
              isFromUser: false,
            ),
          );
        });
        _scrollToBottom();
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(), 
        ),
        title: Text('AI Chat', style: theme.textTheme.titleLarge),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: colorScheme.secondaryContainer,
            ),
          ),
        ],
        
        elevation: 0,
        scrolledUnderElevation: 1, 
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
                hintText: 'Tulis pesanmu di sini',
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
            onPressed: _sendMessage,
            backgroundColor: colorScheme.primary,
            elevation: 2,
            child: Icon(Icons.send, color: colorScheme.onPrimary),
          ),
        ],
      ),
    );
  }
}
