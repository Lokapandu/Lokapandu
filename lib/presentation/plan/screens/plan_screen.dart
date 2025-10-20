import 'package:flutter/material.dart';
import 'package:lokapandu/presentation/plan/providers/tour_plan_notifier.dart';
import 'package:provider/provider.dart';

import '../widgets/expanding_fab.dart';
import '../widgets/plan_timeline_item.dart';
import '../widgets/plan_shimmer_loading.dart';

class PlanScreen extends StatefulWidget {
  final String? message;

  const PlanScreen({super.key, this.message});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      if (mounted) {
        await context.read<TourPlanNotifier>().fetchItineraries();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // PERBAIKAN: Pindahkan ke post frame callback
    if (widget.message != null && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final scaffoldMessenger = ScaffoldMessenger.of(this.context);
        final banner = MaterialBanner(
          padding: EdgeInsets.all(20),
          content: Text('${widget.message}'),
          actions: [
            TextButton(
              onPressed: () => scaffoldMessenger.hideCurrentMaterialBanner(),
              child: const Text('Dismiss'),
            ),
          ],
        );
        scaffoldMessenger.showMaterialBanner(banner);

        // Auto-dismiss after 5 seconds
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted) {
            scaffoldMessenger.hideCurrentMaterialBanner();
          }
        });
      });
    }

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerHigh,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        // Efek bayangan saat di-scroll
        scrolledUnderElevation: 4.0,
        shadowColor: theme.shadowColor.withValues(alpha: 0.1),
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          'Rencana Wisata',
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.calendar_today_outlined,
              color: colorScheme.onSurface,
            ),
            onPressed: () {
              // TODO: Implementasi logika untuk membuka kalender
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<TourPlanNotifier>(
        builder: (context, notifier, child) {
          if (notifier.isLoading) {
            return const PlanShimmerLoading();
          }
          
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              24,
              16,
              24,
              100,
            ), // Padding bawah ditambah
            itemCount: notifier.planItems.length,
            itemBuilder: (context, index) {
              return PlanTimelineItem(item: notifier.planItems[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          );
        },
      ),
      floatingActionButton: const ExpandingFab(),
    );
  }
}
