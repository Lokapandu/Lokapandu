import 'package:flutter/material.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/settings/providers/bookmark_provider.dart';
import 'package:provider/provider.dart';

enum BookmarkButtonType { outlined, icon }

class BookmarkButton extends StatelessWidget {
  const BookmarkButton({
    super.key,
    required this.tour,
    this.buttonType = BookmarkButtonType.outlined,
  });

  final TourismSpot tour;
  final BookmarkButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Consumer<BookmarkProvider>(
      builder: (context, bookmarkProvider, child) {
        final isBookmarked = bookmarkProvider.bookmarkedSpots?.any((spot) => spot.id == tour.id) ?? false;

        if (buttonType == BookmarkButtonType.outlined) {
          return OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              side: BorderSide(
                color: isBookmarked ? colorScheme.primary : colorScheme.outline,
                width: isBookmarked ? 2 : 1,
              ),
            ),
            onPressed: () async {
              if (isBookmarked) {
                await bookmarkProvider.removeTourismValueById(tour.id);
              } else {
                await bookmarkProvider.saveTourismValue(tour);
              }
              await bookmarkProvider.loadAllTourismValue();
            },
            child: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border_outlined,
            ),
          );
        }

        return IconButton(
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_border_outlined,
          ),
          onPressed: () async {
            if (isBookmarked) {
              await bookmarkProvider.removeTourismValueById(tour.id);
            } else {
              await bookmarkProvider.saveTourismValue(tour);
            }
            await bookmarkProvider.loadAllTourismValue();
          },
        );
      },
    );
  }
}
