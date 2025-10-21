import 'package:flutter/material.dart';
import 'package:lokapandu/presentation/plan/providers/tour_plan_notifier.dart';
import 'package:provider/provider.dart';

import '../widgets/expanding_fab.dart';
import '../widgets/plan_timeline_item.dart';
import '../widgets/plan_shimmer_loading.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  DateTime? selectedDate;
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      if (mounted) {
        final error = await context.read<TourPlanNotifier>().fetchItineraries();
        if (error != null) {
          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(error)));
          }
        }
      }
    });
  }

  Future<void> _selectDate() async {
    final notifier = context.read<TourPlanNotifier>();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: notifier.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      // Mengatur tanggal yang dipilih ke awal hari (00:00:00) untuk memastikan filter bekerja dengan benar
      final startOfDay = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      );
      notifier.setSelectedDate(startOfDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = context.read<TourPlanNotifier>();
      if (mounted) {
        print('selectedDate: ${notifier.selectedDate}');
      }
    });

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
            onPressed: () => _selectDate(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<TourPlanNotifier>(
        builder: (context, notifier, child) {
          if (notifier.isLoading) {
            return const PlanShimmerLoading();
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(
              24,
              16,
              24,
              100,
            ), // Padding bawah ditambah
            itemCount: notifier.planItems.length,
            itemBuilder: (context, index) {
              final isSameDate =
                  index > 0 &&
                  notifier.planItems[index].date.day ==
                      notifier.planItems[index - 1].date.day;
              return PlanTimelineItem(
                item: notifier.planItems[index],
                showDate: !isSameDate,
              );
            },
          );
        },
      ),
      floatingActionButton: const ExpandingFab(),
    );
  }
}
