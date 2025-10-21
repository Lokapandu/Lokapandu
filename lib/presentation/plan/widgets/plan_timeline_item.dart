import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/plan_item_model.dart';
import 'plan_card.dart';

class PlanTimelineItem extends StatelessWidget {
  final PlanItem item;
  final bool showDate;

  const PlanTimelineItem({super.key, required this.item, this.showDate = true});

  Color _getIndicatorColor(PlanItemType type, ColorScheme colorScheme) {
    switch (type) {
      case PlanItemType.tour:
        return colorScheme.primary;
      case PlanItemType.note:
        return colorScheme.tertiary;
      case PlanItemType.activity:
        return colorScheme.secondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(width: 30, child: _buildTimelineIndicator(context)),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: PlanCard(item: item),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineIndicator(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (showDate) ...[
          Text(
            '${DateFormat('EEE').format(item.date)}\n${DateFormat('d').format(item.date)}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
        ],
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorScheme.surface,
            border: Border.all(
              color: _getIndicatorColor(item.type, colorScheme),
              width: 3,
            ),
          ),
        ),
        Expanded(child: Container(width: 2, color: colorScheme.outlineVariant)),
      ],
    );
  }
}
