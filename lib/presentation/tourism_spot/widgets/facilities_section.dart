import 'package:flutter/material.dart';
import 'facility_icon.dart';
import '../models/facility_model.dart';

class FacilitiesSection extends StatelessWidget {
  final String facilities;

  const FacilitiesSection({
    super.key,
    required this.facilities,
  });

  @override
  Widget build(BuildContext context) {
    final parsedFacilities = FacilityModel.parseFacilities(facilities);
    final iconFacilities = FacilityModel.getIconFacilities(parsedFacilities);
    final textFacilities = FacilityModel.getTextFacilities(parsedFacilities);

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
        if (iconFacilities.isNotEmpty) ...[
          SizedBox(
            height: 110,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              scrollDirection: Axis.horizontal,
              itemCount: iconFacilities.length,
              itemBuilder: (context, index) {
                final facility = iconFacilities[index];
                return FacilityIcon(
                  icon: facility.icon!,
                  label: facility.name,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 16),
            ),
          ),
          const SizedBox(height: 16),
        ],
        if (textFacilities.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: textFacilities.map((facility) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF008080).withOpacity(0.1),
                    border: Border.all(
                      color: const Color(0xFF008080).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    facility.name,
                    style: const TextStyle(
                      color: Color(0xFF008080),
                      fontSize: 12,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }
}
