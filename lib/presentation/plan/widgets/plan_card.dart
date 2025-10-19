// File: lib/features/plan/widgets/plan_card.dart

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../models/plan_item_model.dart';

class PlanCard extends StatelessWidget {
  final PlanItem item;
  final VoidCallback? onTap;

  const PlanCard({super.key, required this.item, this.onTap});
  Widget _buildImage(String imageUrl, ColorScheme colorScheme) {
    bool isNetwork = imageUrl.startsWith('http');

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: isNetwork
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(color: colorScheme.surfaceContainerHighest),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.broken_image_outlined),
            )
          : Image.asset(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
    );
  }

  @override
  Widget build(BuildContext context) {
    //  Ambil theme dari context
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Card(
      //  Mengunakan styling dari theme
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      elevation: 0,
      color: colorScheme.surface,
      child: InkWell(
        onTap: onTap, // Hubungkan dengan callback
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (item.type == PlanItemType.tour) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildImage(item.tourImageUrl!, colorScheme),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.tourLocation!,
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Klik untuk lihat detail',
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
