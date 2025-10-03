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

    final primaryImage = spot.images.isNotEmpty
        ? spot.images.first.imageUrl
        : '';
    final location = '${spot.city}, ${spot.province}';

    return Card(
      color: colorScheme.surfaceContainer,
      elevation: 2,
      shadowColor: theme.shadowColor.withOpacity(0.2),
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 100,
                  height: 100,
                  color: colorScheme.surfaceContainerHigh,
                  child: Icon(Icons.broken_image, color: colorScheme.outline),
                ),
              )
            else
              Container(
                width: 100,
                height: 100,
                color: colorScheme.surfaceContainerHigh,
                child: Icon(
                  Icons.image_not_supported,
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
                    style: theme.textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: colorScheme.outline,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.outline,
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
