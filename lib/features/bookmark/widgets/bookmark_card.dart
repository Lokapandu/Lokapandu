import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/bookmark_provider.dart';

class BookmarkCard extends StatelessWidget {
  final TourismSpot spot;
  const BookmarkCard({super.key, required this.spot});

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
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      elevation: 0,
      color: colorScheme.surface,
      child: InkWell(
        onTap: () {
          context.push('/tour-detail', extra: spot);
        },
        child: Row(
          children: [
            if (primaryImage.isNotEmpty)
              CachedNetworkImage(
                imageUrl: primaryImage,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 100,
                  height: 100,
                  color: colorScheme.surfaceContainerHigh,
                ),
                errorWidget: (context, url, error) => Container(
                  width: 100,
                  height: 100,
                  color: colorScheme.surfaceContainerHigh,
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: colorScheme.outline,
                  ),
                ),
              )
            else
              Container(
                width: 100,
                height: 100,
                color: colorScheme.surfaceContainerHigh,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: colorScheme.outline,
                ),
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    spot.name,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  Icons.bookmark,
                  color: colorScheme.primary,
                  size: 28,
                ),
                onPressed: () {
                  context.read<BookmarkProvider>().toggleBookmark(spot);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
