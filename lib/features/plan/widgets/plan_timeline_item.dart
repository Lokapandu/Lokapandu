// File: lib/features/plan/widgets/plan_timeline_item.dart

import 'package:flutter/material.dart';
import '../models/plan_item_model.dart';
import 'plan_card.dart';

class PlanTimelineItem extends StatelessWidget {
  final PlanItem item;
  const PlanTimelineItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTimeIndicator(),
          const SizedBox(width: 16),
          Expanded(child: PlanCard(item: item)),
        ],
      ),
    );
  }

  Widget _buildTimeIndicator() {
    return Column(
      children: [
        Text(item.timeRange.split(' - ')[0], style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green.withOpacity(0.1),
            border: Border.all(color: Colors.green),
          ),
          child: const Text('Min', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
        ),
        const SizedBox(height: 4),
        Text(item.timeRange.split(' - ')[1], style: const TextStyle(color: Colors.grey)),
        const Expanded(
          child: VerticalDivider(color: Colors.green, thickness: 2, width: 20, indent: 8, endIndent: 8),
        ),
      ],
    );
  }
}