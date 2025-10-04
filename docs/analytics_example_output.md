# Analytics Debug Output Example

Berikut adalah contoh output analytics yang akan muncul di debug console ketika mengakses halaman splash screen dan auth:

## Splash Screen Analytics

```
[DEBUG_ANALYTICS] 📊 Page View: splash
  Parameters: {
    screen_name: SplashScreen,
    entry_time: 2024-01-15T10:30:25.123Z
  }

[DEBUG_ANALYTICS] 🎬 Event: animation_started on splash
  Parameters: {
    animation_type: background_zoom
  }

[DEBUG_ANALYTICS] 🎬 Event: animation_started on splash
  Parameters: {
    animation_type: text_fade_slide,
    delay_ms: 500
  }

[DEBUG_ANALYTICS] ⏱️ Timing: splash_screen_duration on splash
  Duration: 3.5 seconds

[DEBUG_ANALYTICS] 🧭 Navigation: splash → auth
  Parameters: {
    navigation_type: auto_redirect,
    total_splash_time_ms: 3500
  }

[DEBUG_ANALYTICS] 👆 User Action: navigate_to_auth on splash
  Parameters: {
    trigger: automatic,
    after_animations: true
  }
```

## Auth Screen Analytics

```
[DEBUG_ANALYTICS] 📊 Page View: auth
  Parameters: {
    screen_name: AuthScreen,
    entry_time: 2024-01-15T10:30:28.623Z,
    source: splash_screen
  }

[DEBUG_ANALYTICS] 👆 User Action: google_sign_in_pressed on auth
  Parameters: {
    button_type: google_sign_in,
    timestamp: 2024-01-15T10:30:35.456Z
  }

[DEBUG_ANALYTICS] 🧭 Navigation: auth → tourism_spot
  Parameters: {
    navigation_type: button_press,
    trigger: google_sign_in
  }
```

## Fitur Analytics yang Diimplementasikan

### 1. **Page View Tracking**
- Melacak kapan user mengakses splash screen dan auth screen
- Mencatat waktu masuk dan sumber navigasi

### 2. **Event Tracking**
- Melacak dimulainya animasi di splash screen
- Mencatat jenis animasi dan delay

### 3. **User Action Tracking**
- Melacak interaksi user seperti menekan tombol Google Sign In
- Mencatat jenis aksi dan timestamp

### 4. **Navigation Tracking**
- Melacak perpindahan antar halaman
- Mencatat jenis navigasi dan trigger

### 5. **Timing Tracking**
- Mengukur durasi splash screen
- Berguna untuk optimasi performa

### 6. **Error Tracking**
- Siap melacak error jika terjadi
- Membantu debugging

## Kegunaan untuk Debugging

1. **Performance Monitoring**: Melihat berapa lama splash screen ditampilkan
2. **User Behavior**: Memahami bagaimana user berinteraksi dengan aplikasi
3. **Navigation Flow**: Melacak alur navigasi user
4. **Animation Performance**: Memantau animasi berjalan dengan baik
5. **Error Detection**: Mendeteksi masalah yang mungkin terjadi

Analytics ini hanya aktif dalam mode debug dan tidak akan muncul di production build.