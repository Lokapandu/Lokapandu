import 'package:flutter/material.dart';
import 'package:lokapandu/presentation/auth/providers/auth_notifier.dart';
import 'package:lokapandu/presentation/common/app_header.dart';
import 'package:lokapandu/presentation/home/widgets/dont_miss_carausel.dart';
import 'package:lokapandu/presentation/home/widgets/home_header.dart';
import 'package:lokapandu/presentation/home/widgets/search_bar.dart';
import 'package:lokapandu/presentation/home/widgets/upcoming_tour_card.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_notifier.dart';
import 'package:provider/provider.dart';

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
    final userName =
        context.read<AuthNotifier>().user?.userMetadata?['full_name'].split(
          ' ',
        )[0] ??
        'User';

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
        children: [
          AppHeader(title: 'Yuk, jalan-jalan, $userName!'),
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
