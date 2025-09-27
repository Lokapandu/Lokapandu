import 'package:flutter/material.dart';
import 'package:lokapandu/features/tour/models/tour_model.dart';
import '../widgets/search_result_card.dart';

class TourSearchScreen extends StatefulWidget {
  const TourSearchScreen({super.key});

  @override
  State<TourSearchScreen> createState() => _TourSearchScreenState();
}

class _TourSearchScreenState extends State<TourSearchScreen> {
  List<Tour> _searchResults = [];

  void _searchWisata(String query) {
    // TODO: Ganti dengan panggilan API Backend
    if (query.isNotEmpty) {
      setState(() {
        _searchResults = [
          Tour(
            imageUrl: 'assets/images/taman_ujung.jpg',
            name: 'Taman Ujung Soekasada',
            location: 'Karangasem, Bali',
            galleryImageUrls: [],
            openingHours: '',
            address: '',
            distanceKm: 0,
            aboutText: '',
            mapImageUrl: '',
            facilities: [],
            tags: [],
          ),
          Tour(
            imageUrl: 'assets/images/tirta_gangga.jpg',
            name: 'Taman Tirta Gangga',
            location: 'Karangasem, Bali',
            galleryImageUrls: [],
            openingHours: '',
            address: '',
            distanceKm: 0,
            aboutText: '',
            mapImageUrl: '',
            facilities: [],
            tags: [],
          ),
        ];
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cari Wisata')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _searchWisata,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Cari wisata...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final tour = _searchResults[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      context,
                      tour,
                    ); // Kirim data tour yang dipilih kembali
                  },
                  child: SearchResultCard(tour: tour),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
