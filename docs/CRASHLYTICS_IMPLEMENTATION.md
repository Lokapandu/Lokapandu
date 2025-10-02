# Firebase Crashlytics Implementation untuk Flutter

## Overview
Implementasi Firebase Crashlytics telah berhasil ditambahkan ke aplikasi Lokapandu untuk mendeteksi dan melaporkan crash aplikasi secara real-time. Implementasi ini disesuaikan dengan arsitektur aplikasi yang menggunakan Supabase dan Firebase SDK.

## Struktur Implementasi

### 1. Dependencies yang Ditambahkan
```yaml
# pubspec.yaml
dependencies:
  firebase_crashlytics: ^5.0.0
```

### 2. Konfigurasi Android
```kotlin
// android/app/build.gradle.kts
plugins {
    id("com.google.firebase.crashlytics")
}

// android/settings.gradle.kts
id("com.google.firebase.crashlytics") version "3.0.2" apply false
```

### 3. File-file yang Dibuat/Dimodifikasi

#### Core Services
- `lib/common/services/crashlytics_service.dart` - Service utama untuk Crashlytics
- `lib/main.dart` - Inisialisasi Crashlytics di aplikasi

#### Error Handling
- `lib/common/utils/error_handler.dart` - Utility untuk menangani error Supabase, Server, dan Connection
- `lib/presentation/common/widgets/error_boundary.dart` - Widget untuk menangkap error di widget tree

#### Monitoring & Tracking
- `lib/common/observers/crashlytics_navigation_observer.dart` - Observer untuk tracking navigasi

#### Testing
- `lib/features/debug/screens/crashlytics_test_screen.dart` - Screen untuk testing implementasi

#### App Integration
- `lib/app.dart` - Integrasi ErrorBoundary ke aplikasi utama

## Fitur yang Diimplementasikan

### 1. Automatic Crash Detection
- **Fatal Crashes**: Otomatis terdeteksi dan dilaporkan
- **Non-Fatal Errors**: Manual reporting untuk error yang tidak menyebabkan crash
- **Flutter Errors**: Error di widget tree otomatis tertangkap

### 2. Custom Error Reporting
```dart
// Contoh penggunaan
await CrashlyticsService.recordError(
  error,
  stackTrace,
  reason: 'Custom error description',
);
```

### 3. User Context Tracking
```dart
// Set user ID
await CrashlyticsService.setUserId('user123');

// Set custom keys
await CrashlyticsService.setCustomKey('feature', 'payment');

// Log custom messages
await CrashlyticsService.log('User performed action X');
```

### 4. Network Error Monitoring
- Menangkap error dari Supabase operations
- Melaporkan connection errors dan server errors
- Menyimpan detail error untuk debugging

### 5. Navigation Tracking
- Melacak perubahan route dalam aplikasi
- Membantu debugging masalah navigasi
- Menyimpan context navigasi saat error terjadi

## Cara Penggunaan

### 1. Error Boundary untuk Widget
```dart
// Wrap widget dengan error boundary
MyWidget().withErrorBoundary(
  errorContext: 'Feature Name',
  fallbackWidget: CustomErrorWidget(),
)
```

### 2. Safe Execution
```dart
// Jalankan operasi dengan error handling otomatis
final result = await ErrorHandler.safeExecute(
  () => riskyOperation(),
  context: 'Operation Name',
  fallbackValue: defaultValue,
);
```

### 3. Supabase Error Handling
```dart
// Handle Supabase errors
try {
  await supabaseOperation();
} on SupabaseException catch (e) {
  await ErrorHandler.handleSupabaseError(e);
}
```

### 4. Navigation Observer
```dart
// Tambahkan ke MaterialApp
MaterialApp(
  navigatorObservers: [CrashlyticsNavigationObserver()],
  // ...
)
```

## Testing

### 1. Test Screen
Gunakan `CrashlyticsTestScreen` untuk testing berbagai jenis error:
- Fatal crashes
- Non-fatal errors
- Supabase errors
- Format errors
- Widget errors

### 2. Manual Testing
```dart
// Test crash (hanya untuk development)
CrashlyticsService.testCrash();

// Test non-fatal error
await CrashlyticsService.recordError(
  Exception('Test error'),
  StackTrace.current,
);
```

## Best Practices yang Diimplementasikan

### 1. Error Context
- Setiap error dilengkapi dengan context yang jelas
- Custom keys untuk debugging yang lebih mudah
- User actions tracking

### 2. Performance
- Lazy initialization untuk menghindari impact pada startup
- Async operations untuk tidak blocking UI
- Efficient error reporting

### 3. Privacy & Security
- Tidak menyimpan data sensitif dalam crash reports
- User ID dapat di-anonymize jika diperlukan
- Filtering untuk data yang tidak boleh dilaporkan

### 4. Development vs Production
- Test screen hanya tersedia dalam development mode
- Different error handling strategies untuk debug vs release
- Proper error messages untuk user

## Monitoring Dashboard

Setelah implementasi, crash reports dapat dilihat di:
1. Firebase Console → Crashlytics
2. Real-time crash monitoring
3. Detailed stack traces
4. User impact analysis
5. Crash-free users percentage

## Troubleshooting

### 1. Crashes Tidak Muncul di Dashboard
- Pastikan Firebase project sudah dikonfigurasi dengan benar
- Cek apakah `google-services.json` sudah ada
- Verifikasi plugin Crashlytics sudah ditambahkan di build.gradle

### 2. Build Errors
- Jalankan `flutter clean` dan `flutter pub get`
- Pastikan versi plugin kompatibel
- Cek konfigurasi Android Gradle

### 3. Testing
- Gunakan debug build untuk testing
- Crash reports mungkin membutuhkan waktu beberapa menit untuk muncul
- Pastikan device terhubung internet

## Maintenance

### 1. Regular Updates
- Update Firebase Crashlytics plugin secara berkala
- Monitor breaking changes di changelog
- Test implementasi setelah update

### 2. Monitoring
- Review crash reports secara rutin
- Prioritize fixes berdasarkan impact
- Monitor crash-free users percentage

### 3. Optimization
- Tambahkan custom keys sesuai kebutuhan
- Optimize error messages untuk clarity
- Remove unused error tracking code

## Kesimpulan

Implementasi Firebase Crashlytics telah berhasil disesuaikan dengan arsitektur aplikasi yang menggunakan:
✅ Supabase untuk database operations
✅ Firebase SDK untuk analytics dan crashlytics
✅ Google Sign-In untuk authentication

Fitur yang tersedia:
✅ Automatic crash detection
✅ Custom error reporting
✅ Supabase error monitoring
✅ Navigation tracking
✅ User context tracking
✅ Comprehensive error handling
✅ Testing capabilities
✅ Production-ready configuration

Aplikasi sekarang dapat mendeteksi dan melaporkan crash secara real-time dengan fokus pada error handling yang relevan untuk stack teknologi yang digunakan.