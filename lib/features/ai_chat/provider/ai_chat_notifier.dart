import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/chat_message_model.dart';

class AiChatNotifier extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  late final String _userId;

  final List<ChatMessage> _messages = [];
  bool _isFetchingHistory = true;
  bool _isLoading = false;
  bool _isClearing = false;

  List<ChatMessage> get messages => _messages;
  bool get isFetchingHistory => _isFetchingHistory;
  bool get isLoading => _isLoading;
  bool get isClearing => _isClearing;

  AiChatNotifier() {
    _initialize();
  }

  void _initialize() {
    final currentUser = _supabase.auth.currentUser;
    if (currentUser == null) {
      _isFetchingHistory = false;
      notifyListeners();
      return;
    }
    _userId = currentUser.id;
    loadChatHistory();
  }

  ChatMessage _getInitialMessage() {
    return const ChatMessage(
      text:
          'Hai! Aku adalah asisten wisatamu. Ada yang bisa aku bantu untuk liburanmu di Bali?',
      isFromUser: false,
    );
  }

  Future<void> loadChatHistory() async {
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
      _messages.addAll(loadedMessages);
    } catch (e) {
      _messages.add(
        const ChatMessage(
          text: 'Gagal memuat riwayat chat.',
          isFromUser: false,
        ),
      );
    } finally {
      _isFetchingHistory = false;
      notifyListeners();
    }
  }

  Future<void> sendMessage(String userMessageText) async {
    if (userMessageText.isEmpty || _isLoading || _isClearing) return;

    final userMessage = ChatMessage(text: userMessageText, isFromUser: true);
    _messages.add(userMessage);
    _isLoading = true;
    notifyListeners();

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

      _messages.add(aiMessage);

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

      _messages.add(
        const ChatMessage(
          text: "Oops! Sepertinya ada masalah. Coba lagi beberapa saat ya.",
          isFromUser: false,
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Menghapus semua riwayat chat user
  Future<bool> clearChatHistory() async {
    _isClearing = true;
    notifyListeners();

    try {
      await _supabase.from('chat_messages').delete().eq('user_id', _userId);
      _messages.clear();
      _messages.add(_getInitialMessage());
      return true; // Berhasil
    } catch (e, s) {
      print('--- KESALAHAN SAAT MENGHAPUS CHAT ---');
      print('ERROR: $e');
      print('STACK TRACE: $s');
      print('---------------------------------');
      return false; // Gagal
    } finally {
      _isClearing = false;
      notifyListeners();
    }
  }
}
