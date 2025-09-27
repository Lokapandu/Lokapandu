import 'package:flutter/material.dart';
import '../../models/tour_model.dart';
import '../../widgets/facility_icon.dart';

class FacilitiesSection extends StatelessWidget {
  final List<Facility> facilities;
  final List<String> tags;

  const FacilitiesSection({
    super.key,
    required this.facilities,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'Fasilitas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 110,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            scrollDirection: Axis.horizontal,
            itemCount: facilities.length,
            itemBuilder: (context, index) {
              final facility = facilities[index];
              return FacilityIcon(icon: facility.icon, label: facility.name);
            },
            separatorBuilder: (context, index) => const SizedBox(width: 16),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 35,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            scrollDirection: Axis.horizontal,
            itemCount: tags.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF008080).withOpacity(0.1),
                ),
                child: Center(
                  child: Text(
                    tags[index],
                    style: const TextStyle(color: Color(0xFF008080)),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
