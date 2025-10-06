import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lokapandu/presentation/home/models/navigation_item_model.dart';

Widget buildBottomNavigation(BuildContext context, int selectedIndex) {
  final theme = Theme.of(context);
  const double cornerRadius = 30.0;
  const double strokeWidth = 1.0;
  final colorScheme = theme.colorScheme;

  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(cornerRadius),
      topRight: Radius.circular(cornerRadius),
    ),
    child: Container(
      color: colorScheme.outlineVariant,
      padding: EdgeInsets.all(strokeWidth),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(cornerRadius - strokeWidth),
          topRight: Radius.circular(cornerRadius - strokeWidth),
        ),
        child: BottomAppBar(
          color: colorScheme.surfaceContainer,
          clipBehavior: Clip.antiAlias,
          elevation: 2,
          child: Row(
            spacing: 2,
            children: [
              ...navigationItems
                  .map(
                    (item) => NavItem(
                      item: item,
                      isSelected:
                          selectedIndex == navigationItems.indexOf(item),
                      onTap: () => context.go(item.path),
                    ),
                  )
                  .take(2),
              // How to give space between items
              const Expanded(child: SizedBox()),
              ...navigationItems
                  .skip(2)
                  .map(
                    (item) => NavItem(
                      item: item,
                      isSelected:
                          selectedIndex == navigationItems.indexOf(item),
                      onTap: () => context.go(item.path),
                    ),
                  ),
            ],
          ),
        ),
      ),
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
        splashColor: colorScheme.primary.withValues(alpha: .1),
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
