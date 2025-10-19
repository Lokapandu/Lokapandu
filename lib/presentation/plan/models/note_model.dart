import 'package:flutter/material.dart';

class Note {
  final String id;
  final String title;
  final String content;
  final DateTime startTime;
  final DateTime endTime;
  final Color color;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.startTime,
    required this.endTime,
    this.color = Colors.orange,
  });
}
