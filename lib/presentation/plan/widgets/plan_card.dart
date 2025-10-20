import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.primary, width: 0.8),
          left: BorderSide(color: colorScheme.primary, width: 5),
          right: BorderSide(color: colorScheme.primary, width: 0.8),
          bottom: BorderSide(color: colorScheme.primary, width: 0.8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(item.title, style: textTheme.titleMedium),
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(item.timeRange, style: textTheme.bodySmall),
          ),
          SizedBox(height: 4),
          if (item.type == PlanItemType.tour && item.tourImageUrl != null) ...[
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: colorScheme.outline),
              ),
              tileColor: colorScheme.surfaceContainerHigh,
              contentPadding: const EdgeInsets.all(8.0),
              leading: _buildImage(item.tourImageUrl!, colorScheme),
              title: Text(
                item.tourLocation!,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.near_me_outlined,
                    size: 14,
                    color: Color(0xFFA5A5A5),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "Klik untuk lihat detail wisata",
                      style: textTheme.bodySmall?.copyWith(
                        color: Color(0xFFA5A5A5),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
