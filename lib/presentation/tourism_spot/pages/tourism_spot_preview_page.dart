import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:lokapandu/common/routes/routing_list.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_detail_notifier.dart';

class TourismSpotPreviewPage extends StatefulWidget {
  final int id;
  const TourismSpotPreviewPage({super.key, required this.id});

  @override
  State<TourismSpotPreviewPage> createState() => _TourismSpotPreviewPageState();
}

class _TourismSpotPreviewPageState extends State<TourismSpotPreviewPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<TourismSpotDetailNotifier>().loadTourismSpotDetail(
          widget.id,
        );
      }
    });
  }

  bool _isNetworkUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Pratinjau Wisata',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<TourismSpotDetailNotifier>(
        builder: (context, notifier, child) {
          if (notifier.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (notifier.errorMessage != null) {
            return Center(child: Text(notifier.errorMessage!));
          }
          if (notifier.tourismSpot == null) {
            return const Center(child: Text('Wisata tidak ditemukan'));
          }

          final tour = notifier.tourismSpot!;

          return Stack(
            children: [
              Positioned.fill(
                child: Hero(
                  tag: '${tour.name}_${tour.hashCode}',
                  child: _buildBackgroundImage(context),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                      decoration: BoxDecoration(
                        color: colorScheme.surface.withValues(alpha: 0.25),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        border: Border.all(
                          color: colorScheme.onSurface.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tour.name,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: colorScheme.onPrimary,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${tour.city}, ${tour.province}',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildGalleryThumbnails(context, notifier.selectedImage),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              context.push(
                                Routing.tourismSpotDetail.fullPath,
                                extra: tour,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Lihat Detail Wisata',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBackgroundImage(BuildContext context) {
    final notifier = context.watch<TourismSpotDetailNotifier>();
    final selectedImage = notifier.selectedImage;

    if (selectedImage.isEmpty) {
      return Container(
        color: Colors.grey.shade300,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Center(child: Icon(Icons.image_not_supported)),
      );
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 1.2, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                ),
              ),
              child: child,
            ),
          );
        },
        child: _isNetworkUrl(selectedImage)
            ? CachedNetworkImage(
                key: ValueKey<String>(selectedImage),
                imageUrl: selectedImage,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.broken_image, color: Colors.grey),
              )
            : Image.asset(
                selectedImage,
                key: ValueKey<String>(selectedImage),
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  // Helper widget untuk menampilkan thumbnail galeri
  Widget _buildGalleryThumbnails(BuildContext context, String selectedImage) {
    final images = context.watch<TourismSpotDetailNotifier>().images;
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () {
                context.read<TourismSpotDetailNotifier>().selectImage(
                  image.imageUrl,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: image.imageUrl == selectedImage
                      ? Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 3.0,
                        )
                      : null,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    image.imageUrl == selectedImage ? 9.0 : 12.0,
                  ),
                  child: _isNetworkUrl(image.imageUrl)
                      ? CachedNetworkImage(
                          imageUrl: image.imageUrl,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          image.imageUrl,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
