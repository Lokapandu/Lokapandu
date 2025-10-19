import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMapSection extends StatefulWidget {
  final String tourName;
  final double latitude;
  final double longitude;

  const LocationMapSection({
    super.key,
    required this.tourName,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<LocationMapSection> createState() => _LocationMapSectionState();
}

class _LocationMapSectionState extends State<LocationMapSection> {
  late GoogleMapController mapController;
  late final LatLng center;
  late Marker _marker;

  @override
  void initState() {
    super.initState();
    center = LatLng(widget.latitude, widget.longitude);
    _marker = Marker(
      markerId: MarkerId(widget.tourName),
      position: center,
      infoWindow: InfoWindow(title: widget.tourName),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Peta Lokasi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 250,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: center,
                  zoom: 11.0,
                ),
                markers: {_marker},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
