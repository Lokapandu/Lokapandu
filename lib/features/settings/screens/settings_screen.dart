import 'package:flutter/material.dart';
import '../widgets/settings_tile.dart';
import '../../bookmark/screens/bookmark_screen.dart'; // Import halaman Bookmark

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // State untuk mengelola nilai toggle
  bool _isNotificationOn = true;
  bool _isDarkModeOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFA),
      appBar: AppBar(
        title: const Text(
          'Pengaturan',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // Item Notifikasi
          SettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notifikasi',
            subtitle: 'Dapatkan notifikasi mengenai wisata yang menarik.',
            actionType: TileAction.toggle,
            toggleValue: _isNotificationOn,
            onToggleChanged: (value) {
              setState(() {
                _isNotificationOn = value;
                // TODO: Simpan preferensi notifikasi
              });
            },
          ),

          const Divider(thickness: 0.5, height: 24),

          // Item Tema Gelap
          SettingsTile(
            icon: Icons.palette_outlined,
            title: 'Tema Gelap',
            subtitle:
                'Tersedia tema terang dan gelap. Ubah tema sesuai kebutuhan.',
            actionType: TileAction.toggle,
            toggleValue: _isDarkModeOn,
            onToggleChanged: (value) {
              setState(() {
                _isDarkModeOn = value;
                // TODO: Implementasikan logika ganti tema
              });
            },
          ),

          const Divider(thickness: 0.5, height: 24),

          // Item Bookmark
          SettingsTile(
            icon: Icons.bookmark_border,
            title: 'Bookmark',
            subtitle: 'Wisata tersimpan',
            // Tidak perlu actionType karena default-nya adalah navigasi
            onTap: () {
              // Navigasi ke halaman Bookmark saat diklik
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookmarkScreen()),
              );
            },
          ),

          const Divider(thickness: 0.5, height: 24),

          // Item Tentang Pengembang
          SettingsTile(
            icon: Icons.info_outline,
            title: 'Tentang Pengembang',
            subtitle: 'Lokapandu by BEKUP B25-PG008 Team',
            onTap: () {
              // TODO: Tampilkan dialog atau halaman 'Tentang Kami'
            },
          ),
        ],
      ),
    );
  }
}
