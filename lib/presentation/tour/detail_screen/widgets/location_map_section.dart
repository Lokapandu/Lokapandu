import 'package:flutter/material.dart';

class LocationMapSection extends StatelessWidget {
  final String mapImageUrl;

  const LocationMapSection({super.key, required this.mapImageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Peta Lokasi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(mapImageUrl, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
