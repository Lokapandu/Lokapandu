class Note {
  final String? id; 
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
