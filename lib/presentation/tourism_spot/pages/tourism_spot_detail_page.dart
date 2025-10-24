import 'package:flutter/material.dart';

import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/tourism_spot/widgets/detail_image_widget.dart';
import 'package:lokapandu/presentation/tourism_spot/widgets/image_caraosel_section.dart';
import '../widgets/about_section.dart';
import '../widgets/action_button_section.dart';
import '../widgets/facilities_section.dart';
import '../widgets/header_section.dart';
import '../widgets/location_map_section.dart';

class TourismSpotDetailPage extends StatelessWidget {
  final TourismSpot tour;

  const TourismSpotDetailPage({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    final imageUrl = tour.images.isNotEmpty ? tour.images.first.imageUrl : '';

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DetailImageWidget(imageUrl: imageUrl),
            HeaderSection(tour: tour),
            const SizedBox(height: 24),
            ImageCarouselSection(images: tour.images),
            const SizedBox(height: 24),
            AboutSection(aboutText: tour.description),
            const SizedBox(height: 24),
            LocationMapSection(
                tourName: tour.name,
                latitude: tour.latitude,
                longitude: tour.longitude,
              ),
            const SizedBox(height: 24),
            FacilitiesSection(facilities: tour.facilities),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: ActionButtonsSection(tour: tour),
      ),
    );
  }
}
