import 'dart:developer' as dev;

import 'package:brick_core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:lokapandu/brick/models/chat.model.dart';
import 'package:lokapandu/brick/repositories/repository.dart';
import 'package:lokapandu/common/errors/exceptions.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/data/mappers/chat_mapper.dart';
import 'package:lokapandu/domain/entities/chat_entity.dart';
import 'package:lokapandu/domain/repositories/chat_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ChatRepositoryImpl implements ChatRepository {
  final SupabaseClient _client;

  ChatRepositoryImpl() : _client = Supabase.instance.client;

  Future<void> _performHistoryClear(List<ChatModel> models) async {
    for (var model in models) {
      await Repository().delete<ChatModel>(model);
    }
  }

  @override
  Future<Either<Failure, Unit>> clearHistory() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return Left(ServerFailure('User not logged in.'));

      final models = await Repository().get<ChatModel>(
        query: Query.where('user_id', user.id),
      );
      await compute(_performHistoryClear, models);
      return Right(unit);
    } on ConnectionException catch (e, st) {
      dev.log(e.message, name: 'Chat Repository', stackTrace: st);
      return Left(ConnectionFailure(e.message));
    } on SchedulingConflictException catch (e) {
      dev.log(e.toString(), name: "Chat Repository");
      return Left(SchedulingConflictFailure(e.message));
    } catch (e, st) {
      dev.log(e.toString(), name: 'Chat Repository', stackTrace: st);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<List<Chat>> getChats() async* {
    try {
      final user = _client.auth.currentUser;
      if (user == null) {
        dev.log('User not logged in.', name: 'Chat Repository');
        throw ServerFailure('User not logged in.');
      }

      final chatsStream = Repository().subscribeToRealtime<ChatModel>(
        query: Query.where('userId', user.id),
      );

      yield* chatsStream.map((results) {
        if (results.isEmpty) {
          return [];
        }

        return results.map((e) => e.toEntity()).toList();
      });
    } on ConnectionException catch (e, st) {
      dev.log(e.message, name: 'Chat Repository', stackTrace: st);
      throw ConnectionFailure(e.message);
    } catch (e, st) {
      dev.log(e.toString(), name: 'Chat Repository', stackTrace: st);
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<Either<Failure, Unit>> storeChat(
    String message,
    bool isFromUser,
  ) async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return Left(ServerFailure('User not logged in.'));

      final chatModel = ChatModel(
        id: Uuid().v4(),
        userId: user.id,
        content: message,
        isFromUser: isFromUser,
        createdAt: DateTime.now(),
      );
      await Repository().upsertOne<ChatModel>(chatModel);
      return Right(unit);
    } on ConnectionException catch (e, st) {
      dev.log(e.message, name: 'Chat Repository', stackTrace: st);
      return Left(ConnectionFailure(e.message));
    } on SchedulingConflictException catch (e) {
      dev.log(e.toString(), name: "Chat Repository");
      return Left(SchedulingConflictFailure(e.message));
    } catch (e, st) {
      dev.log(e.toString(), name: 'Chat Repository', stackTrace: st);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Chat>> ask(String message) async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return Left(ServerFailure('User not logged in.'));

      final response = await _client.functions.invoke(
        'rekomen-wisata',
        body: {'prompt': message},
      );

      final data = response.data['reply'] as String?;
      if (data == null) return Left(ServerFailure('Gagal mendapatkan data.'));

      return Right(
        Chat(
          id: Uuid().v4(),
          content: data,
          isFromUser: false,
          userId: user.id,
          createdAt: DateTime.now(),
        ),
      );
    } on ConnectionException catch (e, st) {
      dev.log(e.message, name: 'Chat Repository', stackTrace: st);
      return Left(ConnectionFailure(e.message));
    } on SchedulingConflictException catch (e) {
      dev.log(e.toString(), name: "Chat Repository");
      return Left(SchedulingConflictFailure(e.message));
    } catch (e, st) {
      dev.log(e.toString(), name: 'Chat Repository', stackTrace: st);
      return Left(ServerFailure(e.toString()));
    }
  }
}
