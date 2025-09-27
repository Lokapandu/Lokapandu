import 'package:flutter/material.dart';
import 'package:lokapandu/presentation/common/app_header.dart';
import 'package:provider/provider.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_notifier.dart';
import 'package:lokapandu/presentation/tourism_spot/widgets/tour_category_chips.dart';
import 'package:lokapandu/presentation/tourism_spot/widgets/destination_card.dart';
import 'package:lokapandu/presentation/tourism_spot/widgets/shimmer_loading.dart';

class TourismSpotPage extends StatefulWidget {
  const TourismSpotPage({super.key});

  @override
  State<TourismSpotPage> createState() => _TourismSpotPageState();
}

class _TourismSpotPageState extends State<TourismSpotPage> {
  //TODO: Remove hardcoded categories
  final List<String> _categories = [
    'Semua',
    'Taman Budaya',
    'Pantai',
    'Alam',
    'Kuliner',
    'Sejarah',
    'Taman Hiburan',
  ];
  String _selectedCategory = 'Semua';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TourismSpotNotifier>().loadTourismSpots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeader(),
            const SizedBox(height: 16),
            _buildSearchAndFilter(),
            const SizedBox(height: 16),
            //TODO: Remove setState and implement proper category handling in filter
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
              child: Consumer<TourismSpotNotifier>(
                builder: (context, notifier, child) {
                  if (notifier.isLoading) {
                    return const TourismSpotShimmerLoading();
                  }
      
                  if (notifier.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            notifier.errorMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<TourismSpotNotifier>()
                                  .loadTourismSpots();
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
      
                  if (!notifier.hasData) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_off, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'Tidak ada wisata ditemukan',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }
      
                  final filteredSpots = _selectedCategory == 'Semua'
                      ? notifier.tourismSpots
                      : notifier.tourismSpots
                            .where((spot) => spot.category == _selectedCategory)
                            .toList();
      
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: filteredSpots.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      return DestinationCard(
                        tourismSpot: filteredSpots[index],
                        onTap: () {
                          // TODO: Navigate to detail page
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

//TODO: Add search and filter
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