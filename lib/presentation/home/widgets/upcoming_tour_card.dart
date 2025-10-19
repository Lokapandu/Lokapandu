import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

class UpcomingTourCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String time;

  const UpcomingTourCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.time,
  });

  // Helper untuk membedakan URL network dan path aset lokal
  bool _isNetworkUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            // DYNAMIC IMAGE: Gunakan CachedNetworkImage untuk URL dari internet
            child: _isNetworkUrl(imageUrl)
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: colorScheme.surfaceContainerHighest),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.broken_image_outlined),
                  )
                : Image.asset(
                    // Fallback untuk gambar lokal
                    imageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selanjutnya',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.outline,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: colorScheme.outline,
                      size: 14,
                    ),
                    const SizedBox(width: 4),

                    Expanded(
                      child: Text(
                        location,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.outline,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.access_time_outlined,
                      color: colorScheme.outline,
                      size: 14,
                    ),
                    const SizedBox(width: 4),

                    Expanded(
                      child: Text(
                        time,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.outline,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
