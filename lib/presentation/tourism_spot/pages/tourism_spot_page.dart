import 'package:flutter/material.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/common/app_header.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_notifier.dart';
import 'package:lokapandu/presentation/tourism_spot/widgets/tour_category_chips.dart';
import 'package:lokapandu/presentation/tourism_spot/widgets/destination_card.dart';
import 'package:lokapandu/presentation/tourism_spot/widgets/shimmer_loading.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/bookmark_provider.dart';
import 'package:lokapandu/presentation/auth/providers/auth_notifier.dart';
import 'dart:developer' as developer;

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
      try {
        context.read<TourismSpotNotifier>().loadTourismSpots();
      } catch (e) {
        debugPrint("Error loading tourism spots on init: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // "Tonton" BookmarkProvider untuk mendapatkan status favorit
    final bookmarkProvider = context.watch<BookmarkProvider>();

    return Scaffold(
      /// TODO: REMOVE THIS CODE AFTER IMPLEMENT LOGOUT UI ON SETTINGS SCREEN
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          try {
            // Show loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );

            // Perform logout
            await context.read<AuthNotifier>().signOut();

            // Close loading dialog
            if (context.mounted) {
              Navigator.of(context).pop();

              // Navigate to auth screen
              context.pushReplacementNamed('auth');
            }
          } catch (e) {
            // Close loading dialog if still open
            if (context.mounted) {
              Navigator.of(context).pop();

              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Gagal logout!'),
                  backgroundColor: Colors.red,
                ),
              );

              developer.log('Logout failed: $e', name: 'TourismSpotPage');
            }
          }
        },
        icon: const Icon(Icons.logout),
        label: const Text('Logout'),
      ),
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
                            onPressed: () => notifier.loadTourismSpots(),
                            child: const Text('Coba Lagi'),
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
                            Icons.location_off_outlined,
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
                      final spot = filteredSpots[index] as TourismSpot;


                      return DestinationCard(
                        tourismSpot: spot,
                        onTap: () {
                          context.push('/tourism_spot/preview/${spot.id}');
                        },
                        
                        isFavorited: bookmarkProvider.isBookmarked(spot),
                        onFavoriteToggle: () {
                          context.read<BookmarkProvider>().toggleBookmark(spot);
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: colorScheme.onSurfaceVariant,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHigh,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.tune, color: colorScheme.onPrimary),
              onPressed: () {
                // TODO: Implementasi filter
              },
            ),
          ),
        ],
      ),
    );
  }
}
