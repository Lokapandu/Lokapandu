import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:provider/provider.dart';

import 'package:lokapandu/common/utils/string_to_timeofday.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_calculation_notifier.dart';

class HeaderSection extends StatefulWidget {
  final TourismSpot tour;

  const HeaderSection({super.key, required this.tour});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  final timeNow = TimeOfDay.now();
  bool isOpen = false;

  bool isTimeOpen = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TourismSpotCalculationNotifier>().calculateDistance(
        LatLng(widget.tour.latitude, widget.tour.longitude),
      );
    });

    isOpen =
        widget.tour.openTime.toTimeOfDay().isBefore(timeNow) &&
        widget.tour.closeTime.toTimeOfDay().isAfter(timeNow);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(
                  widget.tour.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.tertiary.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isOpen ? 'Buka' : 'Tutup',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${widget.tour.openTime.substring(0, 5)} - ${widget.tour.closeTime.substring(0, 5)}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: IconifyIcon(
                  icon: 'fluent:location-28-filled',
                  color: theme.colorScheme.inverseSurface,
                  size: 10,
                ),
              ),
              Expanded(
                child: Consumer<TourismSpotCalculationNotifier>(
                  builder: (context, notifier, child) {
                    String data = '';
                    if (notifier.isPermissionGranted()) {
                      data = notifier.isLoading
                          ? ''
                          : '| ${notifier.distance} dari lokasimu';
                    }

                    return Text(
                      '${widget.tour.address}, ${widget.tour.city}, ${widget.tour.province} $data',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
