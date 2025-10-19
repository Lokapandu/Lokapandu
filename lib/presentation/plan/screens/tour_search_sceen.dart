import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';

import '../widgets/search_result_card.dart';

class TourSearchScreen extends StatefulWidget {
  const TourSearchScreen({super.key});

  @override
  State<TourSearchScreen> createState() => _TourSearchScreenState();
}

class _TourSearchScreenState extends State<TourSearchScreen> {
  List<TourismSpot> _searchResults = [];
  TourismSpot? _selectedSpot;

  // Data pencarian sekarang menggunakan model TourismSpot yang asli
  void _searchWisata(String query) {
    // TODO: Ganti dengan panggilan API Backend
    if (query.isNotEmpty) {
      setState(() {
        _searchResults = [
          TourismSpot(
            id: 101,
            name: 'Candi Jedong',
            description: 'Deskripsi Candi Jedong...',
            category: 'Sejarah',
            city: 'Ngoro',
            province: 'Mojokerto',
            address: 'Alamat Candi Jedong...',
            latitude: -7.6,
            longitude: 112.6,
            openTime: '08:00',
            closeTime: '16:00',
            mapsLink: '',
            images: [], // Isi dengan TourismImage jika ada
            facilities: 'Toilet,Parkir',
            createdAt: DateTime.now(),
          ),
          TourismSpot(
            id: 102,
            name: 'Air Terjun Tretes',
            description: 'Deskripsi Air Terjun Tretes...',
            category: 'Alam',
            city: 'Pacet',
            province: 'Mojokerto',
            address: 'Alamat Air Terjun Tretes...',
            latitude: -7.7,
            longitude: 112.5,
            openTime: '07:00',
            closeTime: '17:00',
            mapsLink: '',
            images: [],
            facilities: 'Warung,Toilet',
            createdAt: DateTime.now(),
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bool isSelectionMade = _selectedSpot != null;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerHigh,
      appBar: AppBar(
        title: const Text('Cari Wisata'),
        backgroundColor: colorScheme.surface,
        scrolledUnderElevation: 4.0,
        shadowColor: theme.shadowColor.withValues(alpha: 0.1),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              onPressed: isSelectionMade
                  ? () {
                      context.pop(_selectedSpot);
                    }
                  : null,
              child: const Text('Pilih'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _searchWisata,
              autofocus: true,
              style: theme.textTheme.bodyLarge,
              decoration: InputDecoration(
                hintText: 'Cari wisata di sekitar Ngoro...',
                hintStyle: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: colorScheme.onSurfaceVariant,
                ),
                filled: true,
                fillColor: colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: colorScheme.outlineVariant),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: colorScheme.primary, width: 2),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final spot = _searchResults[index];
                final bool isSelected = _selectedSpot?.id == spot.id;

                return SearchResultCard(
                  spot: spot,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      _selectedSpot = spot;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
