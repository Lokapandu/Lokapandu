// File: lib/features/plan/widgets/selected_tour_card.dart

import 'package:flutter/material.dart';
import 'package:lokapandu/features/tour/models/tour_model.dart';

class SelectedTourCard extends StatelessWidget {
  final Tour? selectedTour;
  final VoidCallback onTap;

  const SelectedTourCard({super.key, this.selectedTour, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Wisata', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: selectedTour == null
                ? _buildPlaceholder() // Tampilan jika belum ada yang dipilih
                : _buildSelectedTour(
                    selectedTour!,
                  ), // Tampilan jika sudah dipilih
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.add_location_alt_outlined, color: Colors.grey),
        SizedBox(width: 8),
        Text(
          'Pilih Wisata',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildSelectedTour(Tour tour) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            tour.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tour.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                tour.location,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        const Icon(Icons.edit, color: Colors.grey),
      ],
    );
  }
}
