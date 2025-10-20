import 'package:flutter/material.dart';

import '../models/plan_item_model.dart';
import '../widgets/expanding_fab.dart';
import '../widgets/plan_timeline_item.dart';

class PlanScreen extends StatefulWidget {
  final String? message;

  const PlanScreen({super.key, this.message});

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
      tourImageUrl: 'assets/images/tirta_gangga.jpg',
      // Ganti dengan path gambar Anda
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
      tourImageUrl: 'assets/images/taman_ujung.jpg',
      // Ganti dengan path gambar Anda
      tourLocation: 'Bali, Indonesia',
    ),
  ];

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
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          24,
          16,
          24,
          100,
        ), // Padding bawah ditambah
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
