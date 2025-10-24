import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/routes/routing_list.dart';
import 'package:provider/provider.dart';

import 'package:lokapandu/presentation/bookmark/widgets/bookmark_card.dart';
import 'package:lokapandu/presentation/settings/providers/bookmark_provider.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerHigh,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Wisata Tersimpan',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<BookmarkProvider>(
        builder: (context, provider, child) {
          final bookmarkList = provider.bookmarkedSpots ?? [];

          return switch (bookmarkList.isNotEmpty) {
            true => ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: bookmarkList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final spot = bookmarkList[index];
                return BookmarkCard(
                  spot: spot,
                  onTap: () =>
                      context.push(Routing.tourismSpotDetail.fullPath, extra: spot),
                );
              },
            ),
            _ => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 80,
                    color: colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text('Belum Ada Bookmark', style: textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(
                    'Simpan tempat wisata favoritmu di sini.',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.outline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          };
        },
      ),
    );
  }
}
