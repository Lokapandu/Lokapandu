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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TourismSpotNotifier>().loadMoreItems();
    });

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    // Calculate scroll percentage
    double scrollPercentage = 0;
    if (_scrollController.position.maxScrollExtent > 0) {
      scrollPercentage =
          (_scrollController.position.pixels /
              _scrollController.position.maxScrollExtent) *
          100;

      // Print debug information about scrolling percentage
      print('Scrolling percentage: ${scrollPercentage.toStringAsFixed(2)}%');
    }

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      print('Reached 80% threshold, loading more items...');
      context.read<TourismSpotNotifier>().loadMoreItems();
    }
  }

  bool _onScrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent * 0.8) {
      context.read<TourismSpotNotifier>().loadMoreItems();
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Scaffold(
          body: Consumer<TourismSpotNotifier>(
            builder: (context, state, _) {
              return NotificationListener<ScrollNotification>(
                onNotification: _onScrollNotification,
                child: RefreshIndicator(
                  onRefresh: state.refreshData,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: AppHeader(title: 'Temukan wisata'),
                      ),

                      // SliverToBoxAdapter untuk search bar
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: _buildSearchAndFilter(
                            (query) => state.searchQuery = query,
                          ),
                        ),
                      ),

                      // SliverToBoxAdapter untuk kategori
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 13.0),
                          child: TourCategoryChips(
                            categories: state.categories,
                            selectedCategory: state.selectedCategory,
                            onCategorySelected: (category) =>
                                state.category = category,
                          ),
                        ),
                      ),

                      // SliverPadding untuk memberikan jarak
                      const SliverPadding(padding: EdgeInsets.only(top: 20.0)),

                      // Konten utama menggunakan Consumer
                      if (state.error != null && state.isEmpty)
                        SliverFillRemaining(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ErrorMessageViewer(
                              error: state.error as Failure,
                              reload: () => context
                                  .read<TourismSpotNotifier>()
                                  .refreshData(),
                            ),
                          ),
                        )
                      else if (state.isEmpty && state.isLoading)
                        const SliverFillRemaining(
                          child: TourismSpotShimmerLoading(),
                        )
                      else if (state.isEmpty && !state.isLoading)
                        SliverFillRemaining(
                          child: _buildEmptyState(
                            context,
                            'Pencarian tidak ditemukan!',
                            'Coba cari wisata lain, yuk?',
                            'assets/illustrations/curiosity-search-cuate.svg',
                          ),
                        )
                      else
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          sliver: SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 14,
                                  mainAxisSpacing: 22,
                                  childAspectRatio: 0.9506,
                                ),
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              if (state.tourismSpots.isEmpty ||
                                  index >= state.tourismSpots.length) {
                                return const SizedBox.shrink();
                              }
                              final spot = state.tourismSpots[index];
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
                            }, childCount: state.tourismSpots.length),
                          ),
                        ),

                      if (state.error != null ||
                          (state.hasMoreData && state.isLoading))
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: state.error != null
                                ? Column(
                                    children: [
                                      const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                        size: 32,
                                      ),
                                      const SizedBox(height: 8),
                                      const Text('Error loading more items'),
                                      const SizedBox(height: 8),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          state.clearError();
                                          state.loadMoreItems();
                                        },
                                        icon: const Icon(
                                          Icons.refresh,
                                          size: 18,
                                        ),
                                        label: const Text('Retry'),
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      const CircularProgressIndicator(),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Loading more items...',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter(Function(String query) onType) {
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
                  onChanged: onType,
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
                              onType.call('');
                            },
                          )
                        : null,
                  ),
                  onSubmitted: onType,
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
