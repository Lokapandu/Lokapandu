import 'package:flutter/material.dart';

class DontMissCarousel extends StatelessWidget {
  const DontMissCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data untuk carousel
    final List<String> imageUrls = [
      'assets/images/taman_ujung.jpg',
      'assets/images/taman_ujung.jpg',
      'assets/images/taman_ujung.jpg',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'Jangan Lewatkan Ini!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200, // Tentukan tinggi carousel
          child: PageView.builder(
            controller: PageController(
              viewportFraction: 0.8,
            ), // Menampilkan item sebelah
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: AssetImage(imageUrls[index]),
                    fit: BoxFit.cover,
                  ),
                ),
                // Anda bisa menambahkan overlay atau teks di sini jika perlu
              );
            },
          ),
        ),
      ],
    );
  }
}
