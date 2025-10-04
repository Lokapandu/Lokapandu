class NavigationItem {
  final String path;
  final String iconAsset;
  final String label;

  const NavigationItem({
    required this.path,
    required this.iconAsset,
    required this.label,
  });
}

const List<NavigationItem> navigationItems = [
  NavigationItem(
    path: '/home',
    iconAsset: 'assets/icons/home.svg',
    label: 'Beranda',
  ),
  NavigationItem(
    path: '/tourism_spot',
    iconAsset: 'assets/icons/icon_park.svg',
    label: 'Wisata',
  ),
  NavigationItem(
    path: '/plan',
    iconAsset: 'assets/icons/planing.svg',
    label: 'Rencana',
  ),
  NavigationItem(
    path: '/settings',
    iconAsset: 'assets/icons/settings.svg',
    label: 'Pengaturan',
  ),
];
