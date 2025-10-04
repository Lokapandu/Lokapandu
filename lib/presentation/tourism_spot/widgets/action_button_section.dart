import 'package:flutter/material.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';

class ActionButtonsSection extends StatelessWidget {
  const ActionButtonsSection({super.key, required TourismSpot tour});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        top: 16.0,
        bottom: 64.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Tambah ke Rencana Wisata'),
              onPressed: () {
                // TODO: Implement add to plan functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.bookmark_border, size: 28),
            onPressed: () {
              // TODO: Implement bookmark functionality
            },
            style: IconButton.styleFrom(
              side: BorderSide(color: theme.colorScheme.outline),
              padding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }
}
