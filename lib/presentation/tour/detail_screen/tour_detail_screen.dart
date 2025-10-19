// lib/features/tour_detail/screens/tour_detail_screen.dart

import 'package:flutter/material.dart';

import '../models/tour_model.dart';
import 'widgets/about_section.dart';
import 'widgets/action_button_section.dart';
import 'widgets/facilities_section.dart';
import 'widgets/header_section.dart';
import 'widgets/image_caraosel_section.dart';
import 'widgets/location_map_section.dart';
import 'widgets/tour_detail_silver.dart';

class TourDetailScreen extends StatelessWidget {
  final Tour tour;
  const TourDetailScreen({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Widget khusus untuk App Bar
          TourDetailSliverAppBar(imageUrl: tour.imageUrl),

          // Sliver yang berisi semua konten body
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              decoration: const BoxDecoration(
                color: Color(0xFFF7FAFA),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Setiap bagian UI adalah widget-nya sendiri
                  HeaderSection(tour: tour),
                  const SizedBox(height: 24),
                  ImageCarouselSection(imageUrls: tour.galleryImageUrls),
                  const SizedBox(height: 24),
                  AboutSection(aboutText: tour.aboutText),
                  const SizedBox(height: 24),
                  LocationMapSection(mapImageUrl: tour.mapImageUrl),
                  const SizedBox(height: 24),
                  FacilitiesSection(
                    facilities: tour.facilities,
                    tags: tour.tags,
                  ),
                  const SizedBox(height: 32),
                  const ActionButtonsSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
