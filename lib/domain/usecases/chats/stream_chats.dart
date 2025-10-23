import 'package:lokapandu/domain/entities/chat_entity.dart';
import 'package:lokapandu/domain/repositories/chat_repository.dart';

class StreamChats {
  final ChatRepository repository;

  StreamChats(this.repository);

  Stream<List<Chat>> execute() {
    return repository.getChats();
  }
}
