import 'package:flutter/material.dart';
import 'package:lokapandu/features/plan/screens/note_editor_screen.dart';
import 'package:lokapandu/features/plan/screens/tour_plan_editor_screen.dart';

// Helper widget untuk satu opsi (tidak perlu diubah)
class _FabOption extends StatelessWidget {
  const _FabOption({required this.icon, required this.label, this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD281),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.brown[800],
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            backgroundColor: const Color(0xFFFFD281),
            child: Icon(icon, color: Colors.brown[800], size: 22),
          ),
        ],
      ),
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
    return SizedBox(
      width: 250, // Beri area yang cukup
      height: 250,
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          // Tombol Close (yang tidak terlihat)
          FloatingActionButton(
            backgroundColor: const Color(0xFF008080),
            onPressed: _toggle,
            child: const Icon(Icons.close, color: Colors.white),
          ),

          // Opsi-opsi
          _buildExpandingAction(
            distance: 80,
            progress: _expandAnimation,
            child: _FabOption(
              icon: Icons.note_add_outlined,
              label: 'Catatan',
              onTap: () {
                _toggle();
                Navigator.push(
                  context,
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
              label: 'Rencana Pariwisata',
              onTap: () {
                _toggle();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TourPlanEditorScreen(),
                  ),
                );
              },
            ),
          ),

          // Tombol Open (yang terlihat di awal)
          FloatingActionButton(
            backgroundColor: const Color(0xFF008080),
            onPressed: _toggle,
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _expandAnimation,
              color: Colors.white,
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
          right: 0,
          child: Opacity(opacity: progress.value, child: child!),
        );
      },
      child: child,
    );
  }
}
