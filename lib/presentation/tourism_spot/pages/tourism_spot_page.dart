import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/common/routes/routing_list.dart';
import 'package:lokapandu/presentation/common/app_header.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_notifier.dart';
import 'package:lokapandu/presentation/tourism_spot/widgets/destination_card.dart';
import 'package:lokapandu/presentation/tourism_spot/widgets/error_message_widget.dart';
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

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        context.read<TourismSpotNotifier>().loadTourismSpots(refresh: true);
      } catch (e) {
        debugPrint("Error loading tourism spots on init: $e");
      }
    });

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final notifier = context.read<TourismSpotNotifier>();
      if (!notifier.isLoading &&
          !notifier.isLoadingMore &&
          notifier.hasMoreData) {
        notifier.loadTourismSpots();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
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
                      // Panggil filter kategori di notifier saat kategori berubah
                      context.read<TourismSpotNotifier>().filterByCategory(
                        category,
                      );
                    },
                  ),
                ),
              ),

              // SliverPadding untuk memberikan jarak
              const SliverPadding(padding: EdgeInsets.only(top: 20.0)),

              // Konten utama menggunakan Consumer
              Consumer<TourismSpotNotifier>(
                builder: (context, notifier, child) {
                  // notifier.isLoading
                  if (notifier.isLoading) {
                    return const SliverFillRemaining(
                      child: TourismSpotShimmerLoading(),
                    );
                  }
                  // Handle error state
                  if (notifier.hasError) {
                    final error = notifier.error as Failure;
                    return SliverFillRemaining(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ErrorMessageViewer(
                          error: error,
                          reload: () => context
                              .read<TourismSpotNotifier>()
                              .loadTourismSpots(),
                        ),
                      ),
                    );
                  }

                  if (!notifier.hasData) {
                    return SliverFillRemaining(
                      child: _buildEmptyState(
                        context,
                        'Pencarian tidak ditemukan!',
                        'Coba cari wisata lain, yuk?',
                        'assets/illustrations/curiosity-search-cuate.svg',
                      ),
                    );
                  }

                  // Gunakan data langsung dari notifier tanpa filter lokal
                  // Karena filter kategori sudah dihandle di notifier
                  final spots = notifier.tourismSpots;

                  return SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 0.9,
                                ),
                            itemCount:
                                spots.length +
                                (notifier.hasMoreData && !notifier.isLoadingMore
                                    ? 1
                                    : 0),
                            itemBuilder: (context, index) {
                              if (index < spots.length) {
                                final spot = spots[index];
                                return DestinationCard(
                                  tourismSpot: spot,
                                  onTap: () {
                                    context.push(
                                      Routing.tourismSpotPreview.fullPath
                                          .replaceFirst(
                                            ':id',
                                            spot.id.toString(),
                                          ),
                                    );
                                  },
                                );
                              }
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                  ),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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
                final TextEditingController controller = TextEditingController(
                  text: notifier.searchQuery,
                );
                return TextField(
                  controller: controller,
                  onChanged: (query) {
                    context.read<TourismSpotNotifier>().search(query);
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari destinasi wisata...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    suffixIcon: notifier.searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            onPressed: () {
                              controller.clear();
                              context.read<TourismSpotNotifier>().search('');
                            },
                          )
                        : null,
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
