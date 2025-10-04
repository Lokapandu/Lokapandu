import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';

class DestinationCard extends StatelessWidget {
  final TourismSpot tourismSpot;
  final VoidCallback? onTap;

  const DestinationCard({super.key, required this.tourismSpot, this.onTap, required bool isFavorited, required Null Function() onFavoriteToggle});

  bool _isNetworkUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryImage = tourismSpot.images.isNotEmpty
        ? tourismSpot.images.first.imageUrl
        : '';

    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline, // warna border
            width: 1, // ketebalan border
          ),
        ),
        elevation: 0,
        color: theme.colorScheme.surfaceContainer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: '${tourismSpot.name}_${tourismSpot.hashCode}',
                child: Stack(
                  children: [
                    SizedBox.expand(
                      child: primaryImage.isNotEmpty
                          ? (_isNetworkUrl(primaryImage)
                                ? CachedNetworkImage(
                                    imageUrl: primaryImage,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.broken_image,
                                      size: 50,
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  )
                                : Image.asset(
                                    primaryImage,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.broken_image,
                                        size: 50,
                                        color:
                                            theme.colorScheme.onSurfaceVariant,
                                      );
                                    },
                                  ))
                          : Container(
                              color: theme.colorScheme.surfaceContainerHigh,
                              child: Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface.withValues(
                            alpha: 0.9,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: theme.colorScheme.outline.withValues(
                              alpha: 0.3,
                            ),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.bookmark_border,
                          size: 20,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tourismSpot.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: theme.colorScheme.primary,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${tourismSpot.city}, ${tourismSpot.province}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
