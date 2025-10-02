import 'package:flutter/material.dart';
import 'package:lokapandu/presentation/common/app_header.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
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
  final List<String> _categories = [
    'Semua',
    'Taman Budaya & Bersejarah',
    'Pantai & Pesisir',
    'Pusat Seni & Belanja',
    'Wisata Alam',
    'Kafe & Resto',
  ];
  String _selectedCategory = 'Semua';

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
    context.read<TourismSpotNotifier>().filterByCategory(category);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TourismSpotNotifier>().filterByCategory('Semua');
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeader(),
            const SizedBox(height: 16),
            _buildSearchAndFilter(),
            const SizedBox(height: 16),
            TourCategoryChips(
              categories: _categories,
              selectedCategory: _selectedCategory,
              onCategorySelected: _onCategorySelected,
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
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: theme.colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            notifier.errorMessage!,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.error,
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
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_off,
                            size: 64,
                            color: theme.colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Tidak ada wisata ditemukan',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final filteredSpots = notifier.tourismSpots;

                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    itemCount: filteredSpots.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.9,
                        ),
                    itemBuilder: (context, index) {
                      return DestinationCard(
                        tourismSpot: filteredSpots[index],
                        onTap: () {
                          context.go(
                            '/tourism_spot/preview/${filteredSpots[index].id}',
                          );
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

  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (query) {
                context.read<TourismSpotNotifier>().search(query);
              },
              decoration: InputDecoration(
                hintText: 'Cari destinasi wisata...',
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainer,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: Icon(
                Icons.tune,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
