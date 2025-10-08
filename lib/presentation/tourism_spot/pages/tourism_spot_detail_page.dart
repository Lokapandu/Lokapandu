// lib/features/tour_detail/screens/tour_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import '../widgets/about_section.dart';
import '../widgets/action_button_section.dart';
import '../widgets/facilities_section.dart';
import '../widgets/header_section.dart';
import '../widgets/image_caraosel_section.dart';
import '../widgets/location_map_section.dart';
import '../widgets/tour_detail_silver.dart';

class TourismSpotDetailPage extends StatelessWidget {
  final TourismSpot tour;
  const TourismSpotDetailPage({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TourDetailSliverAppBar(
            imageUrl: tour.images.isNotEmpty
                ? tour.images.first.imageUrl
                : '',
          ),
          SliverToBoxAdapter(
            child: Container(
              transform: Matrix4.translationValues(0.0, -24.0, 0.0),
              padding: const EdgeInsets.only(top: 24.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: HeaderSection(tour: tour),
                  ),
                  const SizedBox(height: 24),
                  ImageCarouselSection(images: tour.images),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: AboutSection(aboutText: tour.description),
                  ),
                  const SizedBox(height: 24),
                  LocationMapSection(
                    tourName: tour.name,
                    latitude: tour.latitude,
                    longitude: tour.longitude,
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: FacilitiesSection(
                      facilities: tour.facilities,
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ActionButtonsSection(tour: tour),
    );
  }
}
