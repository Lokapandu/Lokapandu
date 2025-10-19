// File: lib/features/tour/screens/tour_preview_screen.dart

import 'dart:ui';

import 'package:flutter/material.dart';

import '../detail_screen/tour_detail_screen.dart';
import '../models/tour_model.dart';

import 'package:cached_network_image/cached_network_image.dart'; // <-- Tambahkan import

class TourPreviewScreen extends StatelessWidget {
  final Tour tour;
  const TourPreviewScreen({super.key, required this.tour});

  // Helper untuk mengecek URL
  bool _isNetworkUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detail Wisata',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Latar Belakang Gambar
          Positioned.fill(
            // 1. BUNGKUS GAMBAR DENGAN HERO WIDGET
            child: Hero(
              // 2. GUNAKAN TAG YANG SAMA PERSIS DENGAN DI TOURGRIDCARD
              tag: '${tour.name}_${tour.hashCode}',
              child: _buildBackgroundImage(), // Panggil helper gambar
            ),
          ),

          // Kartu Kaca Buram di Bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.35),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tour.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white70,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            tour.location,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Galeri Thumbnail
                      _buildGalleryThumbnails(tour.galleryImageUrls),
                      const SizedBox(height: 24),
                      // Tombol Lihat Detail
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TourDetailScreen(tour: tour),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF008080),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Lihat Detail Wisata',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget untuk menampilkan gambar latar belakang
  Widget _buildBackgroundImage() {
    return _isNetworkUrl(tour.imageUrl)
        ? CachedNetworkImage(
            imageUrl: tour.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                const Icon(Icons.broken_image, color: Colors.grey),
          )
        : Image.asset(tour.imageUrl, fit: BoxFit.cover);
  }

  // Helper widget untuk menampilkan thumbnail galeri
  Widget _buildGalleryThumbnails(List<String> imageUrls) {
    return Row(
      children: imageUrls.take(3).map((url) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: _isNetworkUrl(url)
                  ? CachedNetworkImage(
                      imageUrl: url,
                      height: 70,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(url, height: 70, fit: BoxFit.cover),
            ),
          ),
        );
      }).toList(),
    );
  }
}
