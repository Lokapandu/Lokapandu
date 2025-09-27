// File: lib/features/plan/models/note_model.dart

class Note {
  final String? id; // Akan null saat membuat catatan baru
  final String title;
  final String content;
  final DateTime startTime;
  final DateTime endTime;

  const Note({
    this.id,
    required this.title,
    required this.content,
    required this.startTime,
    required this.endTime,
  });
}
