import 'package:flutter/material.dart';
import 'package:lokapandu/common/utils/string_to_timeofday.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/auth/providers/auth_notifier.dart';
import 'package:lokapandu/presentation/common/app_header.dart';
import 'package:lokapandu/presentation/home/widgets/dont_miss_carausel.dart';
import 'package:lokapandu/presentation/home/widgets/search_bar.dart';
import 'package:lokapandu/presentation/home/widgets/upcoming_tour_card.dart';
import 'package:lokapandu/presentation/plan/providers/tour_plan_notifier.dart';
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
        context.read<TourPlanNotifier>().fetchItineraries();
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                'Rencana Anda',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Consumer<TourPlanNotifier>(
              builder: (context, notifier, child) {
                if (notifier.isLoading) {
                  return const SizedBox(
                    height: 100,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (notifier.hasError) {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'Gagal memuat data: ${notifier.errorMessage}',
                      ),
                    ),
                  );
                }
                if (!notifier.hasData) {
                  return const SizedBox(
                    height: 100,
                    child: Center(child: Text('Belum ada rencana')),
                  );
                }

                final upcomingSpots = notifier.planItems
                    .map((e) => e.tourismSpot)
                    .whereType<TourismSpot>()
                    .take(3)
                    .toList();

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: upcomingSpots.length,
                    itemBuilder: (context, index) {
                      final spot = upcomingSpots[index];
                      return UpcomingTourCard(
                        imageUrl: spot.images.isNotEmpty
                            ? spot.images.first.imageUrl
                            : '',
                        title: spot.name,
                        location: '${spot.city}, ${spot.province}',
                        time:
                            '${spot.openTime.toTimeOfDay().toString24()}-${spot.closeTime.toTimeOfDay().toString24()}',
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
