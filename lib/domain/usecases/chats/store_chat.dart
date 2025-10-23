import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/repositories/chat_repository.dart';

class StoreChat {
  final ChatRepository repository;

  StoreChat(this.repository);

  Future<Either<Failure, Unit>> execute(String message, bool isFromUser) async {
    return await repository.storeChat(message, isFromUser);
  }
}
