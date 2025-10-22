import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/common/routes/routing_list.dart';

class _FabOption extends StatelessWidget {
  const _FabOption({
    required this.icon,
    required this.label,
    this.onTap,
    required this.heroTag,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FloatingActionButton.extended(
      heroTag: heroTag,
      onPressed: onTap,
      label: Text(label),
      icon: Icon(icon, size: 20),
      foregroundColor: colorScheme.secondary,
      backgroundColor: colorScheme.surfaceContainerHigh,
      elevation: 4,
    );
  }
}

class ExpandingFab extends StatefulWidget {
  const ExpandingFab({super.key});

  @override
  State<ExpandingFab> createState() => _ExpandingFabState();
}

class _ExpandingFabState extends State<ExpandingFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  late final Animation<double> _iconAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
    _iconAnimation = Tween<double>(begin: 0.0, end: 0.125).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: 250,
      height: 250,
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildExpandingAction(
            distance: 80,
            progress: _expandAnimation,
            child: _FabOption(
              heroTag: 'fab_note',
              icon: Icons.note_add_outlined,
              label: 'Buat Catatan',
              onTap: () {
                _toggle();
                context.pushNamed(Routing.planAddNote.routeName);
              },
            ),
          ),
          _buildExpandingAction(
            distance: 150,
            progress: _expandAnimation,
            child: _FabOption(
              heroTag: 'fab_plan',
              icon: Icons.map_outlined,
              label: 'Buat Rencana',
              onTap: () {
                _toggle();
                context.pushNamed(Routing.planAdd.routeName);
              },
            ),
          ),
          FloatingActionButton(
            heroTag: 'main_fab',
            shape: const CircleBorder(),
            backgroundColor: colorScheme.primary,
            onPressed: _toggle,
            child: RotationTransition(
              turns: _iconAnimation,
              child: Icon(Icons.add, color: colorScheme.onPrimary, size: 32),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandingAction({
    required double distance,
    required Animation<double> progress,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        return Positioned(
          bottom: progress.value * distance,
          right: 4,
          child: Opacity(opacity: progress.value, child: child!),
        );
      },
      child: child,
    );
  }
}
