import 'package:flutter/material.dart';
import '../models/tour_model.dart';
import '../widgets/tour_category.dart';
import '../widgets/tour_grid_card.dart';

class TourScreen extends StatefulWidget {
  const TourScreen({super.key});

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  final List<String> _categories = [
    'Taman Budaya',
    'Pantai',
    'Alam',
    'Kuliner',
    'Sejarah',
    'Taman Hiburan',
  ];
  String _selectedCategory = 'Taman Budaya';

  final List<Tour> _tours = [
    Tour(
      imageUrl: 'assets/images/tirta_gangga.jpg',
      name: 'Taman Tirta Gangga',
      location: 'Karangasem, Bali',
      galleryImageUrls: [
        'assets/images/tirta_gangga.jpg',
        'assets/images/tirta_gangga.jpg',
        'assets/images/tirta_gangga.jpg',
      ],
      openingHours: '08.00 - 18.00',
      address: 'Jl. Raya Tirta Gangga, Ababi, Karangasem, Bali',
      distanceKm: 4.1,
      aboutText:
          'Tirta Gangga adalah taman air suci yang indah di Karangasem, Bali. Didirikan oleh Raja Anak Agung Anglurah Ketut Karangasem Agung pada tahun 1946, taman ini menampilkan perpaduan arsitektur Bali dan Cina.',
      mapImageUrl: 'assets/images/bali_map_dumy.png',
      facilities: const [
        Facility(icon: Icons.restaurant, name: 'Restoran'),
        Facility(icon: Icons.local_parking, name: 'Parkir'),
        Facility(icon: Icons.deck, name: 'Area Istirahat'),
        Facility(icon: Icons.wc, name: 'Toilet'),
        Facility(icon: Icons.camera_alt, name: 'Spot Foto'),
      ],
      tags: ['Restoran', 'Area Istirahat', 'Spot Foto', 'Wi-Fi'],
    ),
    // Anda bisa menambahkan data wisata lainnya di sini dengan struktur yang sama
    Tour(
      imageUrl: 'assets/images/taman_ujung.jpg',
      name: 'Taman Ujung',
      location: 'Karangasem, Bali',
      galleryImageUrls: [
        'assets/images/taman_ujung.jpg',
        'assets/images/taman_ujung.jpg',
        'assets/images/taman_ujung.jpg',
      ],
      openingHours: '07.00 - 19.00',
      address: 'Jl. Raya Taman Ujung, Tumbu, Karangasem, Bali',
      distanceKm: 5.5,
      aboutText:
          'Taman Ujung, juga dikenal sebagai "Istana Air," adalah kompleks istana indah dengan kolam besar dan arsitektur bersejarah yang menawan.',
      mapImageUrl: 'assets/images/bali_map_dumy.png',
      facilities: const [
        Facility(icon: Icons.local_parking, name: 'Parkir'),
        Facility(icon: Icons.wc, name: 'Toilet'),
        Facility(icon: Icons.camera_alt, name: 'Spot Foto'),
      ],
      tags: ['Sejarah', 'Spot Foto'],
    ),
  ];
  // --- END OF DATA ---

  @override
  Widget build(BuildContext context) {
    // Bagian build tidak ada yang berubah, sudah benar.
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildSearchAndFilter(),
          const SizedBox(height: 20),
          TourCategoryChips(
            categories: _categories,
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                _selectedCategory = category;
              });
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _tours.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                return TourGridCard(tour: _tours[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Icon(Icons.location_on, color: Color(0xFF008080), size: 16),
              SizedBox(width: 8),
              Text(
                'Bali, Indonesia',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Icon(Icons.wb_sunny, color: Colors.orangeAccent, size: 16),
              SizedBox(width: 8),
              Text('27° C Cerah'),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Temukan Wisata',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari wisata',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF008080),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.filter_list, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
