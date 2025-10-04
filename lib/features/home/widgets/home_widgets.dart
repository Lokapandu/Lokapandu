import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/features/home/models/navigation_item_model.dart';

Widget buildCenterButton(BuildContext context) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  return InkWell(
    onTap: () => context.push('/ai_chat'),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: null, // Dibuat null agar tidak bisa ditekan, hanya visual
          backgroundColor: colorScheme.primary,
          elevation: 4.0,
          child: SvgPicture.asset(
            'assets/icons/ai_chat.svg',
            width: 28,
            height: 28,
            colorFilter: ColorFilter.mode(
              colorScheme.onPrimary,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'AI Chat',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}


class NavItem extends StatelessWidget {
  final NavigationItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final color = isSelected ? colorScheme.primary : colorScheme.outline;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent,
        splashColor: colorScheme.primary.withOpacity(0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              item.iconAsset,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: theme.textTheme.bodySmall!.copyWith(
                color: color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
