import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_notifier.dart';
import 'package:lokapandu/features/home/models/navigation_item_model.dart';
import 'package:lokapandu/features/home/widgets/home_header.dart';
import 'package:lokapandu/features/home/widgets/dont_miss_carausel.dart';
import 'package:lokapandu/features/home/widgets/search_bar.dart';
import 'package:lokapandu/features/home/widgets/upcoming_tour_card.dart';
import 'package:lokapandu/features/home/widgets/home_widgets.dart';

class HomeScreen extends StatelessWidget {
  final Widget child;
  const HomeScreen({super.key, required this.child});

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final index = navigationItems.indexWhere(
      (item) => location.startsWith(item.path),
    );
    return index == -1 ? 0 : index;
  }

  void _onNavItemTapped(BuildContext context, int index) {
    context.go(navigationItems[index].path);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final selectedIndex = _getCurrentIndex(context);

    return Scaffold(
      
      backgroundColor: colorScheme.surfaceContainerHigh,
      body: child,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: null,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            color: colorScheme.surfaceContainer,
            elevation: 2,
            child: SizedBox(
              height: 65,
              child: Row(
                children: <Widget>[
                  NavItem(
                    item: navigationItems[0],
                    isSelected: selectedIndex == 0,
                    onTap: () => _onNavItemTapped(context, 0),
                  ),
                  NavItem(
                    item: navigationItems[1],
                    isSelected: selectedIndex == 1,
                    onTap: () => _onNavItemTapped(context, 1),
                  ),
                  const SizedBox(width: 48),
                  NavItem(
                    item: navigationItems[2],
                    isSelected: selectedIndex == 2,
                    onTap: () => _onNavItemTapped(context, 2),
                  ),
                  NavItem(
                    item: navigationItems[3],
                    isSelected: selectedIndex == 3,
                    onTap: () => _onNavItemTapped(context, 3),
                  ),
                ],
              ),
            ),
          ),
          Positioned(bottom: 50, child: buildCenterButton(context)),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<TourismSpotNotifier>().loadTourismSpots();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: HomeHeader(),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: CustomSearchBar(),
          ),
          const SizedBox(height: 24),
          const DontMissCarousel(),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Rekomendasi Untuk Anda',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Consumer<TourismSpotNotifier>(
            builder: (context, notifier, child) {
              if (notifier.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (notifier.hasError) {
                return Center(
                  child: Text('Gagal memuat data: ${notifier.errorMessage}'),
                );
              }
              if (!notifier.hasData) {
                return const Center(child: Text('Belum ada rekomendasi.'));
              }

              final upcomingSpots = notifier.tourismSpots.take(3).toList();

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: upcomingSpots.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final spot = upcomingSpots[index];
                    return UpcomingTourCard(
                      imageUrl: spot.images.isNotEmpty
                          ? spot.images.first.imageUrl
                          : '',
                      title: spot.name,
                      location: '${spot.city}, ${spot.province}',
                      time: 'Dibuka: ${spot.openTime}',
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
