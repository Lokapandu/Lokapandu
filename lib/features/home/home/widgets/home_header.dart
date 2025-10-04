import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, color: Color(0xFF008080), size: 20),
            const SizedBox(width: 8),
            const Text(
              'Bali, Indonesia',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Icon(Icons.wb_sunny, color: Colors.orangeAccent),
            const SizedBox(width: 8),
            const Text('27° C Cerah'),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Yuk, jalan-jalan, Ayu!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
