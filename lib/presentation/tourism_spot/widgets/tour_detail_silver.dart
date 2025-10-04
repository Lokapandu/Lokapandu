import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TourDetailSliverAppBar extends StatelessWidget {
  final String imageUrl;

  // Hanya butuh imageUrl sekarang
  const TourDetailSliverAppBar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SliverAppBar(
      expandedHeight: 280.0,
      pinned: true,
      stretch: true,
      backgroundColor: colorScheme.surface,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        // Bagian 'title' dan 'titlePadding' sudah dihapus dari sini
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (imageUrl.isNotEmpty)
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: colorScheme.surfaceContainerHighest),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.broken_image),
              ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              left: 16,
              child: CircleAvatar(
                backgroundColor: colorScheme.scrim.withOpacity(0.4),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: colorScheme.onPrimary),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colorScheme.scrim.withOpacity(0.6),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
