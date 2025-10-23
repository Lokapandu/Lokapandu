import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/chat_entity.dart';
import 'package:lokapandu/domain/repositories/chat_repository.dart';

class AskAi {
  final ChatRepository repository;

  AskAi(this.repository);

  Future<Either<Failure, Chat>> execute(String message) async {
    return await repository.ask(message);
  }
}
