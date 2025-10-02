# Firebase Analytics Implementation

Implementasi Firebase Analytics yang komprehensif untuk Flutter dengan dukungan debug mode, environment separation, dan best practices.

## 📋 Fitur

- ✅ **Environment Separation**: Konfigurasi terpisah untuk development, staging, dan production
- ✅ **Debug Mode**: Dukungan Firebase DebugView untuk monitoring real-time
- ✅ **Centralized Management**: Analytics manager terpusat untuk semua tracking
- ✅ **Platform Support**: Konfigurasi debug untuk Android dan iOS
- ✅ **Comprehensive Tracking**: Page views, events, user actions, navigation, timing, errors
- ✅ **Error Handling**: Silent error handling dengan logging untuk debugging
- ✅ **Type Safety**: Strongly typed parameters dan return values

## 🚀 Quick Start

### 1. Inisialisasi di main.dart

```dart
import 'package:firebase_core/firebase_core.dart';
import 'common/analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize Analytics Manager
  await AnalyticsManager().initialize();
  
  runApp(MyApp());
}
```

### 2. Track Events di Screen

```dart
import '../common/analytics.dart';

class HomeScreen extends StatefulWidget {
  @override
  void initState() {
    super.initState();
    
    // Track page view
    AnalyticsManager().trackPageView(
      screenName: 'home',
      parameters: {'section': 'main'},
    );
  }
  
  void _onButtonPressed() {
    // Track user action
    AnalyticsManager().trackUserAction(
      action: 'button_click',
      category: 'ui_interaction',
      label: 'primary_button',
    );
  }
}
```

## 🔧 Konfigurasi Environment

### Development Environment
- Debug mode: **Enabled**
- DebugView: **Enabled**
- Console logging: **Enabled**
- Event upload delay: **Minimal**

### Production Environment
- Debug mode: **Disabled**
- DebugView: **Disabled**
- Console logging: **Disabled**
- Event upload delay: **Standard**

## 🐛 Debug Mode Setup

### Android Debug Mode

1. **Otomatis** (melalui kode):
```bash
# Analytics manager akan otomatis menjalankan:
adb shell setprop debug.firebase.analytics.app com.example.lokapandu
```

2. **Manual**:
```bash
# Ganti dengan package name aplikasi Anda
adb shell setprop debug.firebase.analytics.app com.example.lokapandu

# Untuk disable:
adb shell setprop debug.firebase.analytics.app .none.
```

### iOS Debug Mode

1. **Xcode Launch**:
   - Edit Scheme → Run → Arguments
   - Tambahkan: `-FIRDebugEnabled`

2. **Flutter Run** (workaround):
```dart
// Analytics manager akan otomatis mengatur UserDefaults
UserDefaults.standard.set(true, forKey: "FIRDebugEnabled")
```

### Verifikasi Debug Mode

1. Buka [Firebase Console](https://console.firebase.google.com)
2. Pilih project → Analytics → DebugView
3. Pilih device Anda dari dropdown
4. Events akan muncul real-time

## 📊 Event Tracking

### Page Views
```dart
await AnalyticsManager().trackPageView(
  screenName: 'product_detail',
  screenClass: 'ProductDetailScreen',
  parameters: {
    'product_id': '123',
    'category': 'electronics',
  },
);
```

### Custom Events
```dart
await AnalyticsManager().trackEvent(
  eventName: 'feature_used',
  parameters: {
    'feature_name': 'search',
    'search_term': 'smartphone',
  },
);
```

### User Actions
```dart
await AnalyticsManager().trackUserAction(
  action: 'button_click',
  category: 'ui_interaction',
  label: 'add_to_cart',
  value: 1,
  parameters: {
    'product_id': '123',
    'price': 299000,
  },
);
```

### Navigation
```dart
await AnalyticsManager().trackNavigation(
  destination: 'checkout',
  source: 'cart',
  method: 'button_click',
  parameters: {
    'items_count': 3,
    'total_value': 897000,
  },
);
```

### Timing Events
```dart
await AnalyticsManager().trackTiming(
  category: 'performance',
  variable: 'api_response',
  timeInMs: 1250,
  label: 'get_products',
  parameters: {
    'endpoint': '/api/products',
    'cache_hit': false,
  },
);
```

### Error Tracking
```dart
await AnalyticsManager().trackError(
  error: 'Network timeout',
  description: 'Failed to load products',
  fatal: false,
  parameters: {
    'screen': 'product_list',
    'retry_count': 2,
  },
);
```

## 👤 User Management

### Set User ID
```dart
await AnalyticsManager().setUserId('user_12345');
```

### Set User Properties
```dart
await AnalyticsManager().setUserProperty(
  name: 'user_type',
  value: 'premium',
);
```

### Reset Analytics Data
```dart
// Untuk privacy compliance
await AnalyticsManager().resetAnalyticsData();
```

## 🔍 Debug Features

### Print Debug Summary
```dart
// Hanya di debug mode
AnalyticsManager().printDebugSummary();
```

### Get Debug Events
```dart
// Hanya di debug mode
List<Map<String, dynamic>> events = AnalyticsManager().getDebugEvents();
```

### Clear Debug Events
```dart
// Hanya di debug mode
AnalyticsManager().clearDebugEvents();
```

### Environment Info
```dart
Map<String, dynamic> info = AnalyticsManager().environmentInfo;
print('Environment: ${info['environment']}');
print('Debug Mode: ${info['analyticsConfig']['enableDebugMode']}');
```

## 📁 Struktur File

```
lib/common/
├── analytics.dart                     # Main export file
├── config/
│   ├── environment_config.dart        # Environment configuration
│   └── firebase_debug_config.dart     # Debug mode configuration
├── services/
│   ├── analytics_manager.dart         # Centralized analytics manager
│   ├── firebase_analytics_service.dart # Firebase Analytics service
│   └── debug_analytics_service.dart   # Debug analytics service
└── examples/
    └── analytics_usage_example.dart   # Usage examples
```

## 🛠️ Best Practices

### 1. Event Naming
- Gunakan snake_case: `button_click`, `page_view`
- Deskriptif dan konsisten: `product_view`, `product_purchase`
- Hindari PII (Personally Identifiable Information)

### 2. Parameter Guidelines
- Maksimal 25 custom parameters per event
- Parameter name maksimal 40 karakter
- Parameter value maksimal 100 karakter
- Gunakan tipe data yang sesuai (string, number, boolean)

### 3. Performance
- Batch events jika memungkinkan
- Hindari tracking events yang terlalu sering
- Gunakan async/await untuk non-blocking operations

### 4. Privacy
- Jangan track data sensitif (password, email, dll)
- Implementasikan opt-out mechanism
- Reset analytics data saat user logout

### 5. Testing
- Gunakan DebugView untuk validasi events
- Test di berbagai environment
- Verifikasi parameter dan values

## 🚨 Troubleshooting

### Events Tidak Muncul di DebugView

1. **Periksa Debug Mode**:
```dart
print('Debug Mode: ${AnalyticsManager().isDebugMode}');
```

2. **Periksa Package Name**:
```bash
# Android
adb shell getprop debug.firebase.analytics.app

# Harus sama dengan applicationId di build.gradle
```

3. **Periksa iOS Configuration**:
```dart
// Pastikan FIRDebugEnabled diset
UserDefaults.standard.bool(forKey: "FIRDebugEnabled")
```

### Events Tidak Muncul di Production

1. **Periksa Analytics Collection**:
```dart
// Pastikan analytics collection enabled
await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
```

2. **Tunggu Processing Time**:
   - Events bisa memakan waktu 24-48 jam untuk muncul di reports
   - Gunakan DebugView untuk real-time monitoring

### Build Errors

1. **Missing Dependencies**:
```yaml
dependencies:
  firebase_core: ^2.24.2
  firebase_analytics: ^10.7.4
```

2. **Platform Configuration**:
   - Pastikan `google-services.json` (Android) dan `GoogleService-Info.plist` (iOS) sudah ditambahkan
   - Periksa package name consistency

## 📚 Resources

- [Firebase Analytics Documentation](https://firebase.google.com/docs/analytics)
- [FlutterFire Analytics](https://firebase.flutter.dev/docs/analytics/overview)
- [Firebase DebugView](https://firebase.google.com/docs/analytics/debugview)
- [Analytics Best Practices](https://firebase.google.com/docs/analytics/best-practices)

## 🔄 Migration Guide

### Dari Firebase Analytics Service Lama

1. **Replace Import**:
```dart
// Lama
import 'services/firebase_analytics_service.dart';

// Baru
import 'common/analytics.dart';
```

2. **Replace Usage**:
```dart
// Lama
FirebaseAnalyticsService().trackPageView(screenName: 'home');

// Baru
AnalyticsManager().trackPageView(screenName: 'home');
```

3. **Initialize**:
```dart
// Tambahkan di main.dart
await AnalyticsManager().initialize();
```

### Dari Debug Analytics Service Lama

Debug analytics sekarang terintegrasi dalam `AnalyticsManager`. Tidak perlu import terpisah.

## 📝 Changelog

### v2.0.0
- ✅ Implementasi AnalyticsManager terpusat
- ✅ Environment separation
- ✅ Debug mode configuration
- ✅ Platform-specific debug setup
- ✅ Comprehensive error handling
- ✅ Type safety improvements

### v1.0.0
- ✅ Basic Firebase Analytics implementation
- ✅ Debug analytics service
- ✅ Event tracking methods