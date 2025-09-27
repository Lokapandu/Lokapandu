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
  // Dummy data
  final List<PlanItem> _planItems = [
    const PlanItem(
      type: PlanItemType.activity,
      title: 'Berangkat ke Taman Tirta Gangga',
      timeRange: '10.00 - 10.30',
    ),
    const PlanItem(
      type: PlanItemType.tour,
      title: 'Tour di Taman Tirta Gangga',
      timeRange: '10.30 - 12.15',
      tourImageUrl: 'assets/images/tirta_gangga.jpg',
      tourLocation: 'Taman Tirta Gangga',
    ),
    const PlanItem(
      type: PlanItemType.activity,
      title: 'Makan siang di Tirta Ayu',
      timeRange: '12.15 - 13.15',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7FAFA),
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Text(
          'Rencana Pariwisata',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.calendar_today_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 80),
        itemCount: _planItems.length,
        itemBuilder: (context, index) {
          return PlanTimelineItem(item: _planItems[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
      ),
      floatingActionButton: const ExpandingFab(), // Cukup panggil widget ini
    );
  }
}
