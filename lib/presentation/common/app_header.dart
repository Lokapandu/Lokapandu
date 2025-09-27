//TODO: Implement reusable app header widget
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Icon(Icons.location_on, color: Color(0xFF008080), size: 16),
              SizedBox(width: 8),
              Text(
                'Bali, Indonesia',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Icon(Icons.wb_sunny, color: Colors.orangeAccent, size: 16),
              SizedBox(width: 8),
              Text('27° C Cerah'),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Temukan Wisata',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}