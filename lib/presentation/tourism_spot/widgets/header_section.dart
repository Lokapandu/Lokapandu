import 'package:flutter/material.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';

class HeaderSection extends StatelessWidget {
  final TourismSpot tour;
  const HeaderSection({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tour.name,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${tour.openTime} - ${tour.closeTime}',
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Buka',
                  style: TextStyle(
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.grey, size: 16),
              const SizedBox(width: 8),
              Expanded(
                //TODO: Measure the distance of the tourism spot from user's location
                child: Text(
                  '${tour.address}, ${tour.city} (${tour.province} | ... km dari lokasimu)',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
