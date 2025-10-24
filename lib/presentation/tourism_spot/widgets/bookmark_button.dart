import 'package:flutter/material.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/settings/providers/bookmark_provider.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/bookmark_icon_provider.dart';
import 'package:provider/provider.dart';

enum BookmarkButtonType { outlined, icon }

class BookmarkButton extends StatefulWidget {
  const BookmarkButton({
    super.key,
    required this.tour,
    this.buttonType = BookmarkButtonType.outlined,
  });

  final TourismSpot tour;
  final BookmarkButtonType buttonType;

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  @override
  void initState() {
    super.initState();
    final localDb = context.read<BookmarkProvider>();
    final bookmarkIcon = context.read<BookmarkIconProvider>();

    Future.microtask(() async {
      await localDb.loadTourismValueById(widget.tour.id);
      final value = localDb.checkItemBookmark(widget.tour.id);
      bookmarkIcon.isBookmarked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Consumer<BookmarkIconProvider>(
      builder: (context, bookmark, child) {
        final isBookmarked = bookmark.isBookmarked;

        if (widget.buttonType == BookmarkButtonType.outlined) {
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
              final localDb = context.read<BookmarkProvider>();
              if (isBookmarked) {
                await localDb.removeTourismValueById(widget.tour.id);
              } else {
                await localDb.saveTourismValue(widget.tour);
              }
              bookmark.isBookmarked = !isBookmarked;
              localDb.loadAllTourismValue();
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
            final localDb = context.read<BookmarkProvider>();
            if (isBookmarked) {
              await localDb.removeTourismValueById(widget.tour.id);
            } else {
              await localDb.saveTourismValue(widget.tour);
            }
            bookmark.isBookmarked = !isBookmarked;
            localDb.loadAllTourismValue();
          },
        );
      },
    );
  }
}
