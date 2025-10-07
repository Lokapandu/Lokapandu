import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lokapandu/domain/entities/weather_entity.dart';
import 'package:lokapandu/presentation/common/notifier/app_header_notifier.dart';
import 'package:lokapandu/presentation/common/notifier/app_header_state.dart';
import 'package:provider/provider.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:text_scroll/text_scroll.dart';

class AppHeader extends StatefulWidget {
  final String title;
  const AppHeader({super.key, required this.title});

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  @override
  void initState() {
    final notifier = context.read<AppHeaderNotifier>();
    Future.microtask(() {
      notifier.getCurrentWeather();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Consumer<AppHeaderNotifier>(
                      builder: (context, notifier, child) {
                        return switch (notifier.state) {
                          AppHeaderLoading(message: final msg) =>
                            LoadingLocationWidget(message: msg),
                          AppHeaderSuccess(location: final loc) =>
                            LocationSuccessWidget(location: loc),
                          AppHeaderError(
                            message: final msg,
                            technicalDetails: final details,
                          ) =>
                            ErrorLocationWidget(
                              message: msg,
                              technicalDetails: details,
                            ),
                          AppHeaderPermissionDenied(
                            fallbackLocation: final loc,
                          ) =>
                            PermissionDeniedWidget(fallbackLocation: loc),
                        };
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            width: 130,
            child: Consumer<AppHeaderNotifier>(
              builder: (context, notifier, child) {
                return switch (notifier.state) {
                  AppHeaderSuccess(
                    weather: final weather,
                    isWeatherLoading: final loading,
                  ) =>
                    WeatherDisplayWidget(weather: weather, isLoading: loading),
                  AppHeaderPermissionDenied(
                    weather: final weather,
                    isWeatherLoading: final loading,
                  ) =>
                    WeatherDisplayWidget(weather: weather, isLoading: loading),
                  _ => const SizedBox.shrink(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Widget untuk menampilkan loading state
class LoadingLocationWidget extends StatelessWidget {
  final String message;

  const LoadingLocationWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

// Widget untuk menampilkan lokasi sukses
class LocationSuccessWidget extends StatelessWidget {
  final String location;

  const LocationSuccessWidget({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        IconifyIcon(
          icon: 'material-symbols:location-on-rounded',
          color: theme.colorScheme.primary,
          size: 16,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            location,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

// Widget untuk menampilkan error state
class ErrorLocationWidget extends StatelessWidget {
  final String message;
  final String? technicalDetails;

  const ErrorLocationWidget({
    super.key,
    required this.message,
    this.technicalDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        IconifyIcon(
          icon: 'material-symbols:error-rounded',
          color: theme.colorScheme.error,
          size: 16,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (kDebugMode && technicalDetails != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Detail Error: $technicalDetails'),
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            },
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.refresh, size: 16, color: theme.colorScheme.error),
          onPressed: () {
            context.read<AppHeaderNotifier>().getCurrentWeather();
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
        ),
      ],
    );
  }
}

// Widget untuk menampilkan permission denied state
class PermissionDeniedWidget extends StatelessWidget {
  final String fallbackLocation;

  const PermissionDeniedWidget({super.key, required this.fallbackLocation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        IconifyIcon(
          icon: 'material-symbols:location-disabled-rounded',
          color: theme.colorScheme.tertiary,
          size: 16,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            '$fallbackLocation (Default)',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.settings_rounded,
            size: 16,
            color: theme.colorScheme.tertiary,
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Aktifkan izin lokasi di pengaturan untuk lokasi yang akurat',
                ),
                action: SnackBarAction(
                  label: 'Coba Lagi',
                  onPressed: () {
                    context.read<AppHeaderNotifier>().getCurrentWeather();
                  },
                ),
                duration: const Duration(seconds: 4),
              ),
            );
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
        ),
      ],
    );
  }
}

// Widget untuk menampilkan cuaca
class WeatherDisplayWidget extends StatelessWidget {
  final Weather? weather;
  final bool isLoading;

  const WeatherDisplayWidget({
    super.key,
    required this.weather,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isLoading && weather == null) {
      return Row(
        children: [
          SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            'Cuaca...',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      );
    }

    if (!isLoading && weather == null) {
      return Row(
        children: [
          IconifyIcon(
            icon: 'material-symbols:cloud-alert-rounded',
            color: theme.colorScheme.error,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            'Cuaca N/A',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ],
      );
    }

    if (weather != null) {
      return Row(
        children: [
          Image.network(
            'https://${weather?.icon.substring(2)}',
            width: 16,
            height: 16,
            errorBuilder: (context, error, stackTrace) {
              return IconifyIcon(
                icon: 'material-symbols:wb-sunny-rounded',
                color: theme.colorScheme.tertiary,
                size: 16,
              );
            },
          ),
          const SizedBox(width: 4),
          Text(
            '${weather?.celciusTemperature}°C',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          Expanded(
            child: TextScroll(
              '${weather?.text}.',
              mode: TextScrollMode.endless,
              velocity: Velocity(pixelsPerSecond: Offset(40, 0)),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}

class _MarqueeText extends StatefulWidget {
  final String text;
  final TextStyle? temperatureStyle;
  final TextStyle? descriptionStyle;
  final String temperatureText;

  const _MarqueeText({
    required this.text,
    this.temperatureStyle,
    this.descriptionStyle,
    required this.temperatureText,
  });

  @override
  State<_MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<_MarqueeText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _needsScrolling = false;
  double _textWidth = 0;
  double _containerWidth = 0;
  final GlobalKey _textKey = GlobalKey();
  final GlobalKey _containerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfScrollingNeeded();
    });
  }

  @override
  void didUpdateWidget(_MarqueeText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkIfScrollingNeeded();
      });
    }
  }

  void _checkIfScrollingNeeded() {
    final RenderBox? textRenderBox =
        _textKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? containerRenderBox =
        _containerKey.currentContext?.findRenderObject() as RenderBox?;

    if (textRenderBox != null && containerRenderBox != null) {
      _textWidth = textRenderBox.size.width;
      _containerWidth = containerRenderBox.size.width;

      final needsScrolling = _textWidth > _containerWidth;

      if (needsScrolling != _needsScrolling) {
        setState(() {
          _needsScrolling = needsScrolling;
        });

        if (_needsScrolling) {
          // Calculate the distance needed to scroll
          final scrollDistance =
              _textWidth - _containerWidth + 20; // Add some padding

          _animation = Tween<double>(
            begin: 0.0,
            end: scrollDistance,
          ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

          // Start animation with a delay, then repeat
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted && _needsScrolling) {
              _controller.repeat(reverse: false);
            }
          });
        } else {
          _controller.stop();
          _controller.reset();
        }
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _containerKey,
      width: double.infinity,
      child: ClipRect(
        child: _needsScrolling
            ? AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(-_animation.value, 0),
                    child: _buildText(),
                  );
                },
              )
            : _buildText(),
      ),
    );
  }

  Widget _buildText() {
    return Text.rich(
      key: _textKey,
      TextSpan(
        text: widget.temperatureText,
        style: widget.temperatureStyle,
        children: [
          TextSpan(
            text: widget.text.substring(widget.temperatureText.length),
            style: widget.descriptionStyle,
          ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.visible,
      softWrap: false,
    );
  }
}
