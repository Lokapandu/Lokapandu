import 'package:flutter/material.dart';
import 'package:lokapandu/features/ai_chat/screens/ai_chat_screen.dart';
import 'package:lokapandu/features/settings/screens/settings_screen.dart';
import 'package:lokapandu/features/tour/screens/tour_screen.dart';
import '../widgets/home_header.dart';
import '../widgets/dont_miss_carausel.dart';
import '../widgets/search_bar.dart';
import '../widgets/upcoming_tour_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  
  static final List<Widget> _pages = <Widget>[
    _buildHomeContent(),
    const TourScreen(),
    const SettingsScreen(),
    const SettingsScreen(),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFA),
      // IndexedStack menjaga state setiap halaman agar tidak hilang saat berpindah tab
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: _pages),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aksi untuk membuka halaman AI Chat
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AiChatScaffold()),
          );
        },
        backgroundColor: const Color(0xFF008080),
        child: const Icon(Icons.chat_bubble, color: Colors.white),
        elevation: 4.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  _buildNavItem(
                    icon: Icons.home_filled,
                    label: 'Beranda',
                    index: 0,
                  ),
                  _buildNavItem(
                    icon: Icons.park_outlined,
                    label: 'Wisata',
                    index: 1,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildNavItem(
                    icon: Icons.calendar_today_outlined,
                    label: 'Rencana',
                    index: 2,
                  ),
                  _buildNavItem(
                    icon: Icons.settings_outlined,
                    label: 'Pengaturan',
                    index: 3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget untuk membuat setiap item navigasi
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = index == _selectedIndex;
    final color = isSelected ? const Color(0xFF008080) : Colors.grey[400];

    return MaterialButton(
      minWidth: 40,
      onPressed: () => _onNavItemTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget khusus untuk konten Beranda agar build method utama tetap rapi
Widget _buildHomeContent() {
  return ListView(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: HomeHeader(),
      ),
      const SizedBox(height: 24),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: CustomSearchBar(),
      ),
      const SizedBox(height: 24),
      const DontMissCarousel(),
      const SizedBox(height: 32),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Text(
          'Wisata yang akan datang',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
      ),
      const SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            UpcomingTourCard(
              imageUrl: 'assets/images/taman_ujung.jpg',
              title: 'Taman Ujung Soekasada',
              location: 'Kecamatan, Kab',
              time: '12.00 - 13.00',
            ),
            const SizedBox(height: 12),
            UpcomingTourCard(
              imageUrl: 'assets/images/taman_ujung.jpg',
              title: 'Taman Ujung Soekasada',
              location: 'Kecamatan, Kab',
              time: '12.00 - 13.00',
            ),
          ],
        ),
      ),
    ],
  );
}

// Wrapper untuk AiChatScreen agar memiliki Scaffold saat dibuka
class AiChatScaffold extends StatelessWidget {
  const AiChatScaffold({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AiChatScreen());
  }
}
