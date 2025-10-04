import 'package:flutter/material.dart';
import '../models/plan_item_model.dart';
import '../widgets/plan_timeline_item.dart';
import '../widgets/expanding_fab.dart';


class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  // Data dummy yang lebih relevan dengan konteks Bali
  final List<PlanItem> _planItems = [
    const PlanItem(
      type: PlanItemType.activity,
      title: 'Perjalanan ke Tirta Gangga',
      timeRange: '09.00 - 09.30',
    ),
    const PlanItem(
      type: PlanItemType.tour,
      title: 'Eksplorasi Tirta Gangga',
      timeRange: '09.30 - 11.00',
      tourImageUrl:
          'assets/images/tirta_gangga.jpg', 
      tourLocation: 'Bali, Indonesia',
    ),
    const PlanItem(
      type: PlanItemType.activity,
      title: 'Makan Siang di Warung Lokal',
      timeRange: '11.15 - 12.15',
    ),
    const PlanItem(
      type: PlanItemType.tour,
      title: 'Menikmati Pemandangan',
      timeRange: '13.00 - 15.00',
      tourImageUrl:
          'assets/images/taman_ujung.jpg',
      tourLocation: 'Bali, Indonesia',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerHigh,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 4.0,
        shadowColor: theme.shadowColor.withOpacity(0.1),
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
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          24,
          16,
          24,
          100,
        ), 
        itemCount: _planItems.length,
        itemBuilder: (context, index) {
          return PlanTimelineItem(item: _planItems[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
      ),
      floatingActionButton: const ExpandingFab(),
    );
  }
}
