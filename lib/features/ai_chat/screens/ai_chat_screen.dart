import 'package:flutter/material.dart';
import '../models/chat_message_model.dart';
import '../widgets/chat_buble.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController =
      ScrollController(); 
  final List<ChatMessage> _messages = [
    const ChatMessage(
      text: 'Hai, Ayu Krisna! Ada yang bisa aku bantu?',
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
            ChatMessage(
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: ListView.separated(
            controller: _scrollController, // pasang controller
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
        _buildMessageInput(),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Text(
            'AI Chat',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const CircleAvatar(backgroundColor: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Tulis pesanmu di sini',
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            onPressed: _sendMessage,
            backgroundColor: const Color(0xFF008080),
            elevation: 2,
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
