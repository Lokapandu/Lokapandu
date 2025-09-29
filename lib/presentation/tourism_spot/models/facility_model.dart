import 'package:flutter/material.dart';

class FacilityModel {
  final String name;
  final IconData? icon;
  final bool hasIcon;

  const FacilityModel({required this.name, this.icon, required this.hasIcon});

  static const Map<String, IconData> _facilityIcons = {
    'area parkir': Icons.local_parking,
    'parkir': Icons.local_parking,
    'toilet': Icons.wc,
    'toilet dan kamar ganti': Icons.wc,
    'kamar ganti': Icons.wc,
    'spot foto': Icons.camera_alt,
    'foto': Icons.camera_alt,
    'souvenir': Icons.card_giftcard,
  };

  static List<FacilityModel> parseFacilities(String facilitiesString) {
    if (facilitiesString.isEmpty) return [];

    final facilityNames = facilitiesString
        .split(',')
        .map((facility) => facility.trim())
        .where((facility) => facility.isNotEmpty)
        .toList();

    return facilityNames.map((name) {
      final lowerName = name.toLowerCase();
      final icon = _facilityIcons[lowerName];

      return FacilityModel(name: name, icon: icon, hasIcon: icon != null);
    }).toList();
  }

  static List<FacilityModel> getIconFacilities(List<FacilityModel> facilities) {
    return facilities.where((facility) => facility.hasIcon).toList();
  }

  static List<FacilityModel> getTextFacilities(List<FacilityModel> facilities) {
    return facilities.where((facility) => !facility.hasIcon).toList();
  }
}
