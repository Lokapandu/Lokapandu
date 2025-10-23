import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_supabase/brick_supabase.dart';

@ConnectOfflineFirstWithSupabase(
  supabaseConfig: SupabaseSerializable(tableName: 'chat_messages'),
)
class ChatModel extends OfflineFirstWithSupabaseModel {
  @Supabase(unique: true)
  @Sqlite(index: true, unique: true)
  final String id;

  final String userId;
  final String content;
  final bool isFromUser;
  final DateTime createdAt;

  ChatModel({
    required this.id,
    required this.userId,
    required this.content,
    required this.isFromUser,
    required this.createdAt,
  });
}
