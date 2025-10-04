import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    const String location = 'Bali, Indonesia';
    const String weather =
        '24° C Cerah Berawan'; 
    const String userName = 'Ayu';
    const String greeting =
        'Selamat pagi, $userName!'; 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            
            Icon(Icons.location_on, color: colorScheme.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              location,
              
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            
            Icon(Icons.wb_sunny, color: colorScheme.tertiary, size: 20),
            const SizedBox(width: 8),
            Text(
              weather,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          greeting,
          
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
