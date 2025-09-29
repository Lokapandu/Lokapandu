import 'dart:ui';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lokapandu/presentation/tourism_spot/providers/tourism_spot_detail_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TourismSpotPreviewPage extends StatefulWidget {
  final int id;
  const TourismSpotPreviewPage({super.key, required this.id});

  @override
  State<TourismSpotPreviewPage> createState() => _TourismSpotPreviewPageState();
}

class _TourismSpotPreviewPageState extends State<TourismSpotPreviewPage> {
  bool _isNetworkUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TourismSpotDetailNotifier>().loadTourismSpotDetail(
        widget.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Detail Wisata',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<TourismSpotDetailNotifier>(
        builder: (context, notifier, child) {
          if (notifier.isLoading) {
            //TODO: Implement shimmer. Keep this as is for now.
            return const Center(child: CircularProgressIndicator());
          } else if (notifier.errorMessage != null) {
            //TODO: Implement more end-user friendly error message. Keep this as is for now.
            return Center(child: Text(notifier.errorMessage!));
          } else if (notifier.tourismSpot == null) {
            return const Center(child: Text('Tourism spot not found'));
          } else {
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
                          color: theme.colorScheme.scrim.withValues(
                            alpha: 0.35,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          border: Border.all(
                            color: theme.colorScheme.onPrimary.withValues(
                              alpha: 0.2,
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tour.name,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: theme.colorScheme.onPrimary,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${tour.city}, ${tour.province}',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onPrimary,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Galeri Thumbnail
                            _buildGalleryThumbnails(context),
                            const SizedBox(height: 24),
                            // Tombol Lihat Detail
                            ElevatedButton(
                              onPressed: () {
                                context.push(
                                  '/tourism_spot/detail',
                                  extra: tour,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                'Lihat Detail Wisata',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onPrimary,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 48),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  // Helper widget untuk menampilkan gambar latar belakang
  Widget _buildBackgroundImage(BuildContext context) {
    final selectedImage = context
        .watch<TourismSpotDetailNotifier>()
        .selectedImage;
    return _isNetworkUrl(selectedImage)
        ? CachedNetworkImage(
            imageUrl: selectedImage,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                const Icon(Icons.broken_image, color: Colors.grey),
          )
        : Image.asset(selectedImage, fit: BoxFit.cover);
  }

  // Helper widget untuk menampilkan thumbnail galeri
  Widget _buildGalleryThumbnails(BuildContext context) {
    final images = context.watch<TourismSpotDetailNotifier>().images;
    return Row(
      children: images.take(3).map((image) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () {
                context.read<TourismSpotDetailNotifier>().selectImage(
                  image.imageUrl,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: _isNetworkUrl(image.imageUrl)
                    ? CachedNetworkImage(
                        imageUrl: image.imageUrl,
                        height: 70,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        image.imageUrl,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
