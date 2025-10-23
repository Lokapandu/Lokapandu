import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/chat_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, Chat>> ask(String message);

  Stream<List<Chat>> getChats();

  Future<Either<Failure, Unit>> storeChat(String message, bool isFromUser);

  Future<Either<Failure, Unit>> clearHistory();
}
