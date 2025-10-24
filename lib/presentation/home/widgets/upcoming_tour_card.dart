import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:lokapandu/common/routes/routing_list.dart';
import 'package:lokapandu/common/utils/string_to_timeofday.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';

class UpcomingTourCard extends StatelessWidget {
  final String id;
  final TourismSpot spot;

  const UpcomingTourCard({super.key, required this.id, required this.spot});

  // Helper untuk membedakan URL network dan path aset lokal
  bool _isNetworkUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final imageUrl = spot.images.isNotEmpty ? spot.images.first.imageUrl : '';
    final title = spot.name;
    final location = '${spot.city}, ${spot.province}';
    final time =
        '${spot.openTime.toTimeOfDay().toString24()}-${spot.closeTime.toTimeOfDay().toString24()}';

    return InkWell(
      onTap: () {
        context.push(Routing.planDetail.fullPath.replaceFirst(':id', id));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: colorScheme.outline, width: .5),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              // DYNAMIC IMAGE: Gunakan CachedNetworkImage untuk URL dari internet
              child: _isNetworkUrl(imageUrl)
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: colorScheme.surfaceContainerHighest),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.broken_image_outlined),
                    )
                  : Image.asset(
                      // Fallback untuk gambar lokal
                      imageUrl,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selanjutnya',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: .75),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            IconifyIcon(
                              icon: 'mdi:location',
                              color: colorScheme.secondary,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                location,
                                style: textTheme.labelSmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        height: 20,
                        child: VerticalDivider(
                          thickness: 1,
                          color: colorScheme.outline.withValues(alpha: 0.5),
                          width: 1,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Row(
                          children: [
                            IconifyIcon(
                              icon: 'tabler:clock-filled',
                              color: colorScheme.secondary,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                time,
                                style: textTheme.labelSmall,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
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
  }
}
