import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/repositories/chat_repository.dart';

class ClearChatHistory {
  final ChatRepository repository;

  ClearChatHistory(this.repository);

  Future<Either<Failure, Unit>> execute() async {
    return await repository.clearHistory();
  }
}
