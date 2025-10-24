import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

class DetailImageWidget extends StatelessWidget {
  const DetailImageWidget({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 350 + MediaQuery.of(context).padding.top,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          if (imageUrl.isNotEmpty)
            CachedNetworkImage(
              width: double.infinity,
              height: double.infinity,
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(color: theme.colorScheme.surfaceContainerHighest),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.broken_image),
            ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.colorScheme.scrim.withValues(alpha: 0.8),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5],
              ),
            ),
          ),
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            child: CircleAvatar(
              backgroundColor: theme.colorScheme.scrim.withValues(alpha: 0.4),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: theme.colorScheme.onPrimary,
                ),
                onPressed: () => context.pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
