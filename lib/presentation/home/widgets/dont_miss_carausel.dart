import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

class _CarouselItem {
  final String imageUrl;
  final String title;
  final String location;

  const _CarouselItem({
    required this.imageUrl,
    required this.title,
    required this.location,
  });
}

class DontMissCarousel extends StatelessWidget {
  const DontMissCarousel({super.key});

  static final List<_CarouselItem> _carouselItems = [
    _CarouselItem(
      imageUrl: 'assets/images/taman_ujung.jpg',
      title: 'Taman Ujung',
      location: 'Bali',
    ),
    _CarouselItem(
      imageUrl: 'assets/images/tirta_gangga.jpg',
      title: 'Tirta Gangga',
      location: 'Bali',
    ),
    _CarouselItem(
      imageUrl: 'assets/images/taman_ujung.jpg',
      title: 'Taman Ujung',
      location: 'Bali',
    ),
  ];

  Widget _buildCarouselImage(String imageUrl, ColorScheme colorScheme) {
    bool isNetwork = imageUrl.startsWith('http');

    return isNetwork
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Container(color: colorScheme.surfaceContainerHighest),
            errorWidget: (context, url, error) =>
                const Icon(Icons.broken_image_outlined),
          )
        : Image.asset(imageUrl, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'Jangan Lewatkan Ini!',

            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: PageController(
              viewportFraction: 0.85, // Sedikit lebih lebar
            ),
            itemCount: _carouselItems.length,
            itemBuilder: (context, index) {
              final item = _carouselItems[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 4,
                shadowColor: colorScheme.shadow.withValues(alpha: 0.1),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildCarouselImage(item.imageUrl, colorScheme),

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            colorScheme.scrim.withValues(alpha: 0.8),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.5, 1.0],
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: textTheme.titleLarge?.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.location,
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onPrimary.withValues(
                                alpha: 0.9,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
