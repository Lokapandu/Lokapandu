import 'package:flutter/material.dart';
import 'package:lokapandu/features/plan/screens/note_editor_screen.dart';
import 'package:lokapandu/features/plan/screens/tour_plan_editor_screen.dart';

class _FabOption extends StatelessWidget {
  const _FabOption({required this.icon, required this.label, this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FloatingActionButton.extended(
      onPressed: onTap,
      heroTag: null,
      label: Text(label, style: theme.textTheme.labelLarge),
      icon: Icon(icon, size: 20),
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
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
          FloatingActionButton(
            heroTag: 'close_fab',
            backgroundColor: colorScheme.primary,
            onPressed: _toggle,
            child: Icon(Icons.close, color: colorScheme.onPrimary),
          ),
          _buildExpandingAction(
            distance: 80,
            progress: _expandAnimation,
            child: _FabOption(
              icon: Icons.note_add_outlined,
              label: 'Buat Catatan',
              onTap: () {
                _toggle();
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (context) => const NoteEditorScreen(),
                  ),
                );
              },
            ),
          ),
          _buildExpandingAction(
            distance: 150,
            progress: _expandAnimation,
            child: _FabOption(
              icon: Icons.map_outlined,
              label: 'Buat Rencana',
              onTap: () {
                _toggle();
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (context) => const TourPlanEditorScreen(),
                  ),
                );
              },
            ),
          ),
          FloatingActionButton(
            heroTag: 'open_fab',
            backgroundColor: colorScheme.primary,
            onPressed: _toggle,
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _expandAnimation,
              color: colorScheme.onPrimary,
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
