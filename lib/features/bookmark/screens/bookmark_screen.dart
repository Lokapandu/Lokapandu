import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/bookmark_provider.dart'; 
import '../widgets/bookmark_card.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bookmarkProvider = context.watch<BookmarkProvider>();
    final bookmarkedSpots = bookmarkProvider.bookmarkedSpots;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => context.pop(),
        ),
        title: Text('Bookmark', style: theme.textTheme.titleLarge),
        centerTitle: true,
      ),
     
      body: bookmarkedSpots.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bookmark_add_outlined, size: 80, color: colorScheme.outline),
                    const SizedBox(height: 16),
                    Text(
                      'Belum Ada Bookmark',
                      style: theme.textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tekan ikon bookmark pada destinasi wisata untuk menyimpannya di sini.',
                      style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.outline),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              itemCount: bookmarkedSpots.length,
              itemBuilder: (context, index) {
                return BookmarkCard(spot: bookmarkedSpots[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            ),
    );
  }
}