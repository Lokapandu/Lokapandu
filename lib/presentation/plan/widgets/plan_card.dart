import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/routes/routing_list.dart';

import '../models/plan_item_model.dart';

class PlanCard extends StatelessWidget {
  final PlanItem item;
  final VoidCallback? onTap;

  const PlanCard({super.key, required this.item, this.onTap});

  Color _getIndicatorColor(PlanItemType type, ColorScheme colorScheme) {
    switch (type) {
      case PlanItemType.tour:
        return colorScheme.primary;
      case PlanItemType.note:
        return colorScheme.tertiary;
      case PlanItemType.activity:
        return colorScheme.secondary;
    }
  }

  Widget _buildImage(String imageUrl, ColorScheme colorScheme) {
    bool isNetwork = imageUrl.startsWith('http');

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: isNetwork
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(color: colorScheme.surfaceContainerHighest),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.broken_image_outlined),
            )
          : Image.asset(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
    );
  }

  @override
  Widget build(BuildContext context) {
    //  Ambil theme dari context
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: _getIndicatorColor(item.type, colorScheme),
            width: 0.8,
          ),
          left: BorderSide(
            color: _getIndicatorColor(item.type, colorScheme),
            width: 5,
          ),
          right: BorderSide(
            color: _getIndicatorColor(item.type, colorScheme),
            width: 0.8,
          ),
          bottom: BorderSide(
            color: _getIndicatorColor(item.type, colorScheme),
            width: 0.8,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: InkWell(
              onTap: () {
                context.push(
                  Routing.planDetail.fullPath.replaceFirst(
                    ':id',
                    item.tourPlanModel.id.toString(),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      item.title,
                      style: textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(item.timeRange, style: textTheme.bodySmall),
                  ),
                ],
              ),
            ),
          ),
          if (item.type == PlanItemType.tour && item.tourismSpot != null) ...[
            SizedBox(height: 10),
            Material(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: colorScheme.outline),
                ),
                onTap: () => context.push(
                  Routing.tourismSpotDetail.fullPath,
                  extra: item.tourismSpot!,
                ),
                tileColor: colorScheme.surfaceContainerHigh,
                contentPadding: const EdgeInsets.all(8.0),
                leading: _buildImage(
                  item.tourismSpot!.images.first.imageUrl,
                  colorScheme,
                ),
                title: Text(
                  item.tourismSpot!.address,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Row(
                  children: [
                    Icon(
                      Icons.near_me_outlined,
                      size: 14,
                      color: Color(0xFFA5A5A5),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "Klik untuk lihat detail wisata",
                        style: textTheme.bodySmall?.copyWith(
                          color: Color(0xFFA5A5A5),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
