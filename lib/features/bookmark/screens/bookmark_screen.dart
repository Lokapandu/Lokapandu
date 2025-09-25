import 'package:flutter/material.dart';
import '../../tour/models/tour_model.dart';
import '../widgets/bookmark_card.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  // Nanti data ini akan diambil dari database lokal atau state management
  final List<Tour> _bookmarkedTours = [
    // Contoh data
    Tour(
      imageUrl: 'assets/images/taman_ujung.jpg',
      name: 'Taman Ujung Soekasada',
      location: 'Karangasem, Bali',
      // Properti lain diisi dengan data dummy jika diperlukan
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Bookmark',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: _bookmarkedTours.length,
        itemBuilder: (context, index) {
          return BookmarkCard(tour: _bookmarkedTours[index]);
        },
      ),
    );
  }
}
