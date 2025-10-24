import 'dart:developer' as dev;

import 'package:lokapandu/common/errors/exceptions.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/data/mappers/chat_mapper.dart';
import 'package:lokapandu/data/models/ai_chat_model.dart';
import 'package:lokapandu/domain/entities/chat_entity.dart';
import 'package:lokapandu/domain/repositories/chat_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ChatRepositoryImpl implements ChatRepository {
  final SupabaseClient _client;

  ChatRepositoryImpl() : _client = Supabase.instance.client;

  User get _currentUser {
    final user = _client.auth.currentUser;
    if (user == null) {
      dev.log('User not logged in.', name: 'Chat Repository');
      throw ServerFailure('User not logged in.');
    }
    return user;
  }

  @override
  Future<void> clearHistory() async {
    try {
      await _client
          .from('chat_messages')
          .delete()
          .eq('user_id', _currentUser.id);
    } on ConnectionException catch (e, st) {
      dev.log(e.message, name: 'Chat Repository', stackTrace: st);
      throw ConnectionFailure(e.message);
    } on SchedulingConflictException catch (e) {
      dev.log(e.toString(), name: "Chat Repository");
      throw SchedulingConflictFailure(e.message);
    } catch (e, st) {
      dev.log(e.toString(), name: 'Chat Repository', stackTrace: st);
      throw ServerFailure(e.toString());
    }
  }

  @override
  Stream<List<Chat>> subscribeChat() async* {
    try {
      final chatStream = _client
          .from('chat_messages')
          .stream(primaryKey: ['id'])
          .eq('user_id', _currentUser.id)
          .order('created_at', ascending: true);

      await for (final event in chatStream) {
        final chats = event
            .map((e) => AiChatModel.fromJson(e).toEntity())
            .toList();
        yield chats;
      }
    } on RealtimeSubscribeException catch (e, st) {
      dev.log(
        'Realtime subscription error: ${e.toString()}',
        name: 'Chat Repository',
        stackTrace: st,
      );
      throw ConnectionFailure('Realtime connection failed: ${e.toString()}');
    } on ConnectionException catch (e, st) {
      dev.log(e.message, name: 'Chat Repository', stackTrace: st);
      throw ConnectionFailure(e.message);
    } catch (e, st) {
      dev.log(e.toString(), name: 'Chat Repository', stackTrace: st);
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<List<Chat>> getChatHistory() async {
    try {
      final response = await _client
          .from('chat_messages')
          .select()
          .eq('user_id', _currentUser.id)
          .order('created_at', ascending: true);

      return response.map((e) => AiChatModel.fromJson(e).toEntity()).toList();
    } on ConnectionException catch (e, st) {
      dev.log(e.message, name: 'Chat Repository', stackTrace: st);
      throw ConnectionFailure(e.message);
    } catch (e, st) {
      dev.log(e.toString(), name: 'Chat Repository', stackTrace: st);
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<String?> generateResponse(String message) async {
    try {
      final response = await _client.functions.invoke(
        'rekomen-wisata',
        body: {'prompt': message},
      );

      final data = response.data['reply'] as String?;
      if (data == null) {
        throw ServerFailure('Gagal mendapatkan data.');
      }
      dev.log('AI Said: $data', name: 'Chat Repository');
      return data;
    } on ConnectionException catch (e, st) {
      dev.log(e.message, name: 'Chat Repository', stackTrace: st);
      throw ConnectionFailure(e.message);
    } on SchedulingConflictException catch (e) {
      dev.log(e.toString(), name: "Chat Repository");
      throw SchedulingConflictFailure(e.message);
    } catch (e, st) {
      dev.log(e.toString(), name: 'Chat Repository', stackTrace: st);
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> storeChat(String message, bool isUser) async {
    try {
      final chatModel = AiChatModel(
        id: Uuid().v4(),
        userId: _currentUser.id,
        content: message,
        isFromUser: isUser,
        createdAt: DateTime.now(),
      );

      await _client.from('chat_messages').insert(chatModel.toJson());
    } on ConnectionException catch (e, st) {
      dev.log(e.message, name: 'Chat Repository', stackTrace: st);
      throw ConnectionFailure(e.message);
    } on SchedulingConflictException catch (e) {
      dev.log(e.toString(), name: "Chat Repository");
      throw SchedulingConflictFailure(e.message);
    } catch (e, st) {
      dev.log(e.toString(), name: 'Chat Repository', stackTrace: st);
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> storeMultipleChats(List<({String message, bool isUser})> messages) async {
    try {
      if (messages.isEmpty) return;

      final now = DateTime.now();
      final chatModels = messages.map((msg) => AiChatModel(
        id: Uuid().v4(),
        userId: _currentUser.id,
        content: msg.message,
        isFromUser: msg.isUser,
        createdAt: now,
      )).toList();

      final jsonList = chatModels.map((model) => model.toJson()).toList();
      
      // Batch insert - atomic operation
      await _client.from('chat_messages').insert(jsonList);
      
      dev.log('Stored ${messages.length} chat messages in batch', name: 'Chat Repository');
    } on ConnectionException catch (e, st) {
      dev.log(e.message, name: 'Chat Repository', stackTrace: st);
      throw ConnectionFailure(e.message);
    } on SchedulingConflictException catch (e) {
      dev.log(e.toString(), name: "Chat Repository");
      throw SchedulingConflictFailure(e.message);
    } catch (e, st) {
      dev.log(e.toString(), name: 'Chat Repository', stackTrace: st);
      throw ServerFailure(e.toString());
    }
  }
}
