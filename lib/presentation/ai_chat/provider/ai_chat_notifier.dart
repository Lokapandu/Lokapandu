import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lokapandu/data/mappers/chat_mapper.dart';
import 'package:lokapandu/domain/entities/chat_entity.dart';
import 'package:lokapandu/domain/repositories/chat_repository.dart';
import 'package:lokapandu/presentation/ai_chat/models/chat_message_model.dart';

class AiChatNotifier extends ChangeNotifier {
  final ChatRepository _repository;

  AiChatNotifier({required ChatRepository repository})
    : _repository = repository {
    _loadChatHistory();
    _initStream();
  }

  final List<ChatMessage> _chats = [];
  StreamSubscription<Chat>? _chatsStream;

  List<ChatMessage> get chats => _chats;

  Future<void> _loadChatHistory() async {
    try {
      final initialChats = await _repository.getChatHistory();
      _chats.clear();
      if (initialChats.isEmpty) {
        _chats.add(
          ChatMessage(
            text:
                'Hai! Aku adalah asisten wisatamu. Ada yang bisa aku bantu untuk liburanmu di Bali?',
            isFromUser: false,
          ),
        );
      }
      _chats.addAll(initialChats.map((e) => e.toChatMessage()));
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Unexpected error: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _initStream() {
    _chatsStream = _repository.subscribeChat().listen((newChats) {
      _chats.removeWhere((chat) => chat.isTyping);
      _chats.clear();
      _chats.add(newChats.map((chat) => chat.toChatMessage()));
      notifyListeners();
    });
  }

  bool _isLoading = false;
  bool _isClearing = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;

  bool get isClearing => _isClearing;

  bool get hasError => _errorMessage != null;

  String? get errorMessage => _errorMessage;

  Future<void> loadChatHistory() async {
    _isLoading = true;
    notifyListeners();
  }

  Future<void> sendMessage(String userMessageText) async {
    if (userMessageText.isEmpty || _isLoading) return;
    final userMessage = ChatMessage(text: userMessageText, isFromUser: true);
    final typingIndicator = ChatMessage(
      text: '...',
      isFromUser: false,
      isTyping: true,
    );

    _chats.addAll([userMessage, typingIndicator]);
    notifyListeners();

    try {
      // generate response
      final responseText = await _repository.generateResponse(userMessageText);
      if (responseText == null) {
        _errorMessage = 'Failed to generate response.';
        return;
      }
      // store response
      await _repository.storeChat(userMessageText, true);
      await _repository.storeChat(responseText, false);
    } catch (e) {
      _errorMessage = 'Unexpected error: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> clearChatHistory() async {
    try {
      _isClearing = true;
      notifyListeners();
      await _repository.clearHistory();
      _isClearing = false;
    } catch (e) {
      _errorMessage = 'Unexpected error: ${e.toString()}';
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _chatsStream?.cancel();
    super.dispose();
  }
}
