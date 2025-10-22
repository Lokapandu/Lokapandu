import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/routes/routing_list.dart';
import 'package:lokapandu/presentation/common/app_header.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_notifier.dart';
import 'package:lokapandu/presentation/tourism_spot/widgets/destination_card.dart';
import 'package:lokapandu/presentation/tourism_spot/widgets/shimmer_loading.dart';
import 'package:lokapandu/presentation/tourism_spot/widgets/tour_category_chips.dart';
import 'package:provider/provider.dart';

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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: AppHeader(title: 'Temukan wisata')),

              // SliverToBoxAdapter untuk search bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: _buildSearchAndFilter(),
                ),
              ),

              // SliverToBoxAdapter untuk kategori
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 13.0),
                  child: TourCategoryChips(
                    categories: _categories,
                    selectedCategory: _selectedCategory,
                    onCategorySelected: (category) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                ),
              ),

              // SliverPadding untuk memberikan jarak
              const SliverPadding(padding: EdgeInsets.only(top: 20.0)),

              // Konten utama menggunakan Consumer
              Consumer<TourismSpotNotifier>(
                builder: (context, notifier, child) {
                  if (notifier.isLoading) {
                    return const SliverToBoxAdapter(
                      child: TourismSpotShimmerLoading(),
                    );
                  }

                  if (notifier.hasError) {
                    return SliverToBoxAdapter(
                      child: Center(
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
                      ),
                    );
                  }

                  if (!notifier.hasData) {
                    return SliverToBoxAdapter(
                      child: _buildEmptyState(
                        context,
                        'Pencarian tidak ditemukan!',
                        'Coba cari wisata lain, yuk?',
                        'assets/illustrations/curiosity-search-cuate.svg',
                      ),
                    );
                  }

                  final filteredSpots = _selectedCategory == 'Semua'
                      ? notifier.tourismSpots
                      : notifier.tourismSpots
                            .where((spot) => spot.category == _selectedCategory)
                            .toList();

                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.9,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final spot = filteredSpots[index];

                        return DestinationCard(
                          tourismSpot: spot,
                          onTap: () {
                            context.push(
                              Routing.tourismSpotPreview.fullPath.replaceFirst(
                                ':id',
                                spot.id.toString(),
                              ),
                            );
                          },
                        );
                      }, childCount: filteredSpots.length),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: [
          Expanded(
            child: Consumer<TourismSpotNotifier>(
              builder: (context, notifier, _) {
                return TextField(
                  controller: TextEditingController(text: notifier.searchQuery),
                  onChanged: (query) {
                    context.read<TourismSpotNotifier>().search(query);
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari destinasi wisata...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    String title,
    String subtitle,
    String assetPath,
  ) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(assetPath, width: 279, height: 279),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 24,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
