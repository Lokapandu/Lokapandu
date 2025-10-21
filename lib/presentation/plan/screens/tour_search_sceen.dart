import 'dart:async';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:lokapandu/presentation/plan/providers/tour_plan_finding_notifier.dart';
import '../widgets/search_result_card.dart';

class TourSearchScreen extends StatefulWidget {
  const TourSearchScreen({super.key});

  @override
  State<TourSearchScreen> createState() => _TourSearchScreenState();
}

class _TourSearchScreenState extends State<TourSearchScreen> {
  // Timer untuk debouncing
  Timer? _debounce;

  // Data pencarian sekarang menggunakan model TourismSpot yang asli
  Future<void> _searchTourism(String query) async {
    // Batalkan timer sebelumnya jika masih berjalan
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Buat timer baru dengan delay 500ms
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Panggil search di notifier setelah delay
      Provider.of<TourPlanFindingNotifier>(
        context,
        listen: false,
      ).get(query: query);
    });
  }

  @override
  void initState() {
    super.initState();
    final notifier = context.read<TourPlanFindingNotifier>();
    Future.microtask(() {
      notifier.get(
        onError: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error ?? 'Gagal mencari wisata')),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerHigh,
      appBar: AppBar(
        title: const Text('Cari Wisata'),
        backgroundColor: colorScheme.surface,
        scrolledUnderElevation: 4.0,
        shadowColor: theme.shadowColor.withValues(alpha: 0.1),
        actions: [
          Consumer<TourPlanFindingNotifier>(
            builder: (context, notifier, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  onPressed: notifier.selectedSpot != null
                      ? () {
                          context.pop(notifier.selectedSpot);
                        }
                      : null,
                  child: const Text('Pilih'),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _searchTourism,
              autofocus: true,
              style: theme.textTheme.bodyLarge,
              decoration: InputDecoration(
                hintText: 'Cari wisata di sekitar Ngoro...',
                hintStyle: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: colorScheme.onSurfaceVariant,
                ),
                filled: true,
                fillColor: colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: colorScheme.outlineVariant),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: colorScheme.primary, width: 2),
                ),
              ),
            ),
          ),
          Consumer<TourPlanFindingNotifier>(
            builder: (context, notifier, child) {
              if (notifier.isSearching) {
                return const Center(child: CircularProgressIndicator());
              }

              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: notifier.searchResults.length,
                  itemBuilder: (context, index) {
                    final spot = notifier.searchResults[index];
                    final bool isSelected =
                        notifier.selectedSpot?.id == spot.id;

                    return SearchResultCard(
                      spot: spot,
                      isSelected: isSelected,
                      onTap: () => notifier.selectedSpot = spot,
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
