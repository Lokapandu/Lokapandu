[![Codemagic build status](https://api.codemagic.io/apps/68d21507b129bcfa785c9173/68d21507b129bcfa785c9172/status_badge.svg)](https://codemagic.io/app/68d21507b129bcfa785c9173/68d21507b129bcfa785c9172/latest_build)

# Lokapandu

Aplikasi Flutter untuk eksplorasi tempat wisata lokal Indonesia dengan integrasi Firebase dan Supabase.

## 📱 Tentang Aplikasi

Lokapandu adalah aplikasi mobile yang memungkinkan pengguna untuk menemukan dan mengeksplorasi berbagai tempat wisata lokal di Indonesia. Aplikasi ini dibangun menggunakan Flutter dengan arsitektur Clean Architecture dan mengintegrasikan Firebase AI serta Supabase sebagai backend.

## ✨ Fitur Utama

- 🗺️ Eksplorasi tempat wisata berdasarkan lokasi
- 📍 Informasi detail tempat wisata (alamat, jam operasional, fasilitas)
- 🖼️ Galeri foto tempat wisata
- 🔗 Integrasi Google Maps
- 🤖 AI-powered recommendations (Firebase AI)
- 📱 Responsive design untuk berbagai ukuran layar

## 🏗️ Arsitektur

Proyek ini menggunakan **Clean Architecture** dengan pembagian layer sebagai berikut:

```
lib/
├── data/           # Data layer (models, repositories, data sources)
├── domain/         # Domain layer (entities, repositories, use cases)
├── presentation/   # Presentation layer (pages, widgets, providers)
├── common/         # Shared utilities dan failure handling
├── env/           # Environment configuration
└── injection.dart  # Dependency injection setup
```

## 🛠️ Tech Stack

### Framework & Language
- **Flutter** ^3.9.2
- **Dart** ^3.9.2

### State Management
- **Provider** ^6.1.5+1

### Backend & Database
- **Supabase** ^2.10.1 (Database & Authentication)
- **Firebase Core** ^4.1.0
- **Firebase AI** ^3.2.0 (AI recommendations)

### Architecture & Utilities
- **Get It** ^8.2.0 (Dependency Injection)
- **Dartz** ^0.10.1 (Functional Programming)
- **Freezed** ^3.2.3 (Code Generation)
- **JSON Annotation** ^4.9.0 (JSON Serialization)

### Development Tools
- **Envied** ^1.2.1 (Environment Variables)
- **Build Runner** ^2.7.1 (Code Generation)

## 🚀 Instalasi & Setup

### Prerequisites

Pastikan Anda telah menginstall:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (versi 3.9.2 atau lebih baru)
- [Dart SDK](https://dart.dev/get-dart) (versi 3.9.2 atau lebih baru)
- [Android Studio](https://developer.android.com/studio) atau [VS Code](https://code.visualstudio.com/)
- [Git](https://git-scm.com/)

### Langkah Instalasi

1. **Clone repository**
   ```bash
   git clone https://github.com/your-username/lokapandu.git
   cd lokapandu
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Setup Environment Variables**
   ```bash
   # Copy file .env.example ke .env
   cp .env.example .env
   
   # Edit file .env dan isi dengan konfigurasi Anda
   SUPABASE_URL=your-supabase-url
   SUPABASE_KEY=your-supabase-key
   ```

4. **Setup Firebase**
   - Buat project baru di [Firebase Console](https://console.firebase.google.com/)
   - Download `google-services.json` untuk Android dan letakkan di `android/app/`
   - Download `GoogleService-Info.plist` untuk iOS dan letakkan di `ios/Runner/`
   - Jalankan Firebase CLI untuk konfigurasi:
     ```bash
     firebase login
     flutterfire configure
     ```

5. **Setup Supabase**
   - Buat project baru di [Supabase](https://supabase.com/)
   - Dapatkan URL dan anon key dari dashboard Supabase
   - Update file `.env` dengan kredensial Supabase Anda

6. **Generate Code**
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

7. **Run Application**
   ```bash
   # Debug mode
   flutter run
   
   # Release mode
   flutter run --release
   ```

## 📁 Struktur Project

```
lokapandu/
├── android/                 # Android-specific files
├── ios/                     # iOS-specific files
├── lib/
│   ├── app.dart            # Main app widget
│   ├── main.dart           # Entry point
│   ├── injection.dart      # Dependency injection
│   ├── common/             # Shared utilities
│   │   ├── failure.dart    # Error handling
│   │   └── failure.freezed.dart
│   ├── data/
│   │   ├── datasources/    # Remote & local data sources
│   │   ├── models/         # Data models
│   │   └── repositories/   # Repository implementations
│   ├── domain/
│   │   ├── entities/       # Business entities
│   │   ├── repositories/   # Repository contracts
│   │   └── usecases/       # Business logic
│   ├── env/
│   │   └── env.dart        # Environment configuration
│   └── presentation/
│       ├── pages/          # UI screens
│       ├── provider/       # State management
│       └── widgets/        # Reusable UI components
├── test/                   # Unit & widget tests
├── .env.example           # Environment variables template
├── pubspec.yaml           # Dependencies & project config
└── README.md              # Project documentation
```

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

## 📱 Build & Deploy

### Android

```bash
# Build APK
flutter build apk --release

# Build App Bundle (untuk Google Play Store)
flutter build appbundle --release
```

### iOS

```bash
# Build iOS
flutter build ios --release
```

## 🔧 Development

### Code Generation

Proyek ini menggunakan code generation untuk model dan serialization:

```bash
# Generate code sekali
flutter packages pub run build_runner build

# Watch mode (auto-generate saat file berubah)
flutter packages pub run build_runner watch

# Clean dan rebuild
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Environment Variables

Gunakan file `.env` untuk konfigurasi environment:

```env
SUPABASE_URL=your-supabase-url
SUPABASE_KEY=your-supabase-key
```

## 🤝 Contributing

Silakan baca [CONTRIBUTING.md](CONTRIBUTING.md) untuk panduan kontribusi.

## 📄 License

Proyek ini dilisensikan di bawah [MIT License](LICENSE).

## 📞 Support

Jika Anda mengalami masalah atau memiliki pertanyaan:

1. Cek [Issues](https://github.com/your-username/lokapandu/issues) yang sudah ada
2. Buat issue baru jika belum ada
3. Hubungi tim development

## 🙏 Acknowledgments

- [Flutter Team](https://flutter.dev/) untuk framework yang luar biasa
- [Supabase](https://supabase.com/) untuk backend-as-a-service
- [Firebase](https://firebase.google.com/) untuk AI dan analytics
- Komunitas Flutter Indonesia

---

**Happy Coding! 🚀**
