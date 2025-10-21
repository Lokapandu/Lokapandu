import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class PlanShimmerLoading extends StatelessWidget {
  const PlanShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
      itemCount: 5, // Show 5 shimmer items
      itemBuilder: (context, index) {
        return const PlanTimelineShimmerItem();
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }
}

class PlanTimelineShimmerItem extends StatelessWidget {
  const PlanTimelineShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Shimmer.fromColors(
      baseColor: colorScheme.surfaceContainerHigh,
      highlightColor: colorScheme.surface,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTimelineIndicatorShimmer(colorScheme),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: _buildPlanCardShimmer(colorScheme),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineIndicatorShimmer(ColorScheme colorScheme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Time text shimmer
        Container(
          width: 40,
          height: 12,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        // Circle indicator shimmer
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorScheme.surfaceContainerHigh,
          ),
        ),
        // Timeline line shimmer
        Expanded(
          child: Container(width: 2, color: colorScheme.surfaceContainerHigh),
        ),
      ],
    );
  }

  Widget _buildPlanCardShimmer(ColorScheme colorScheme) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 3.0,
      color: colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Image shimmer
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            const SizedBox(width: 16),
            // Content shimmer
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title shimmer
                  Container(
                    width: double.infinity,
                    height: 16,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subtitle shimmer
                  Container(
                    width: 120,
                    height: 12,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description shimmer
                  Container(
                    width: 80,
                    height: 10,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
