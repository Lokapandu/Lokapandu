import 'package:flutter/material.dart';

class Facility {
  final IconData icon;
  final String name;
  const Facility({required this.icon, required this.name});
}

class Tour {
  final String imageUrl;
  final String name;
  final String location;
  final List<String> galleryImageUrls;
  final String openingHours;
  final String address;
  final double distanceKm;
  final String aboutText;
  final String mapImageUrl;
  final List<Facility> facilities;
  final List<String> tags;

  const Tour({
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.galleryImageUrls,
    required this.openingHours,
    required this.address,
    required this.distanceKm,
    required this.aboutText,
    required this.mapImageUrl,
    required this.facilities,
    required this.tags,
  });
}
