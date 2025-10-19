import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';

class SelectedTourCard extends StatelessWidget {
  final TourismSpot? selectedTour;
  final VoidCallback onTap;

  const SelectedTourCard({
    super.key,
    required this.selectedTour,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final Widget content;
    if (selectedTour == null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          color: colorScheme.primary,
          strokeWidth: 2,
          dashPattern: const [8, 4],
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline, color: colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Pilih Destinasi Wisata',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      final primaryImage = selectedTour!.images.isNotEmpty
          ? selectedTour!.images.first.imageUrl
          : '';
      final location = '${selectedTour!.city}, ${selectedTour!.province}';

      content = Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
        elevation: 0,
        color: colorScheme.surface,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: primaryImage,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: colorScheme.surfaceContainerHighest),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.broken_image),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedTour!.name,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        location,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.edit_outlined, color: colorScheme.primary, size: 20),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedTour == null ? 'Pilih Wisata' : 'Wisata Dipilih',
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        content,
      ],
    );
  }
}
