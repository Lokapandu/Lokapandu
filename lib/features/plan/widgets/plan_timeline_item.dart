// File: lib/features/plan/widgets/plan_timeline_item.dart

import 'package:flutter/material.dart';
import '../models/plan_item_model.dart';
import 'plan_card.dart';

class PlanTimelineItem extends StatelessWidget {
  final PlanItem item;
  final VoidCallback? onTap;

  const PlanTimelineItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTimeIndicator(context),
          const SizedBox(width: 16),
          Expanded(
            child: PlanCard(item: item, onTap: onTap),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeIndicator(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          item.timeRange.split(' - ')[0],
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
    
        Expanded(
          child: VerticalDivider(
            color: colorScheme.primary.withOpacity(0.5),
            thickness: 2,
            width: 20,
            endIndent: 4,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // mengunakan warna dari theme
            color: colorScheme.primary.withOpacity(0.1),
            border: Border.all(color: colorScheme.primary.withOpacity(0.5)),
          ),
          child: Text(
            '${_calculateDuration(item.timeRange)} min',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: VerticalDivider(
            color: colorScheme.primary.withOpacity(0.5),
            thickness: 2,
            width: 20,
            indent: 4,
          ),
        ),
        Text(
          item.timeRange.split(' - ')[1],
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  // Helper untuk menghitung durasi (contoh sederhana)
  int _calculateDuration(String timeRange) {
    try {
      final times = timeRange.split(' - ');
      final startTime = TimeOfDay(
        hour: int.parse(times[0].split('.')[0]),
        minute: int.parse(times[0].split('.')[1]),
      );
      final endTime = TimeOfDay(
        hour: int.parse(times[1].split('.')[0]),
        minute: int.parse(times[1].split('.')[1]),
      );

      final startMinutes = startTime.hour * 60 + startTime.minute;
      final endMinutes = endTime.hour * 60 + endTime.minute;

      return endMinutes - startMinutes;
    } catch (e) {
      return 0; // Kembalikan 0 jika format tidak valid
    }
  }
}
