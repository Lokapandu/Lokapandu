import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';

class SearchResultCard extends StatelessWidget {
  final TourismSpot spot;
  final bool isSelected;
  final VoidCallback? onTap;

  const SearchResultCard({
    super.key,
    required this.spot,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final primaryImage = spot.images.isNotEmpty
        ? spot.images.first.imageUrl
        : '';
    final location = '${spot.city}, ${spot.province}';

    return Card(
      // mengunakan styling dari theme ya ges
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
          width: isSelected ? 2.0 : 1.0,
        ),
      ),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: colorScheme.surface,
      child: InkWell(
        onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
                // mengunakan CachedNetworkImage untuk gambar dari internet
                child: CachedNetworkImage(
                  imageUrl: primaryImage,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: colorScheme.surfaceContainerHighest),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      spot.name,
                      style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                        Icon(
                          Icons.location_on_outlined,
                        size: 14,
                          color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected ? colorScheme.primary : colorScheme.outline,
                size: 28,
              ),
          ],
        ),
      ),
      ),
    );
  }
}
