import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/bookmark_provider.dart';

class DestinationCard extends StatelessWidget {
  final TourismSpot tourismSpot;
  final VoidCallback? onTap;

  const DestinationCard({
    super.key,
    required this.tourismSpot,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Consumer<BookmarkProvider>(
      builder: (context, bookmarkProvider, child) {
        final isFavorited = bookmarkProvider.isBookmarked(tourismSpot);

        return Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: tourismSpot.images.isNotEmpty ? tourismSpot.images.first.imageUrl : '',
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.black.withOpacity(0.4),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 22,
                            icon: Icon(
                              isFavorited ? Icons.bookmark : Icons.bookmark_border,
                              color: isFavorited ? colorScheme.primary : Colors.white,
                            ),
                            onPressed: () {
                              bookmarkProvider.toggleBookmark(tourismSpot);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tourismSpot.name,
                        style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, size: 14, color: colorScheme.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${tourismSpot.city}, ${tourismSpot.province}',
                              style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
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
      },
    );
  }
}