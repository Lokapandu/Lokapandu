/// Helper class to convert technical error messages to user-friendly Indonesian messages
class ErrorMessageHelper {
  /// Convert technical error messages to user-friendly Indonesian messages
  static String getReadableErrorMessage(String? errorMessage) {
    if (errorMessage == null || errorMessage.isEmpty) {
      return 'Terjadi kesalahan yang tidak diketahui. Silakan coba lagi.';
    }

    final lowerCaseError = errorMessage.toLowerCase();

    // Network and connection errors
    if (lowerCaseError.contains('network') || 
        lowerCaseError.contains('connection') ||
        lowerCaseError.contains('timeout') ||
        lowerCaseError.contains('no internet')) {
      return 'Koneksi internet bermasalah. Periksa koneksi Anda dan coba lagi.';
    }

    // Google Sign-In specific errors
    if (lowerCaseError.contains('google sign-in was cancelled') ||
        lowerCaseError.contains('cancelled by user') ||
        lowerCaseError.contains('user_canceled')) {
      return 'Proses masuk dibatalkan. Silakan coba lagi jika ingin masuk.';
    }

    if (lowerCaseError.contains('failed to obtain google id token') ||
        lowerCaseError.contains('id token') ||
        lowerCaseError.contains('authentication failed')) {
      return 'Gagal mendapatkan akses dari Google. Silakan coba masuk lagi.';
    }

    if (lowerCaseError.contains('google') && lowerCaseError.contains('sign')) {
      return 'Terjadi masalah saat masuk dengan Google. Pastikan Anda memiliki akun Google yang valid.';
    }

    // Supabase authentication errors
    if (lowerCaseError.contains('failed to authenticate with supabase') ||
        lowerCaseError.contains('supabase')) {
      return 'Gagal terhubung ke server. Silakan coba beberapa saat lagi.';
    }

    // Account or permission errors
    if (lowerCaseError.contains('account') || 
        lowerCaseError.contains('permission') ||
        lowerCaseError.contains('unauthorized')) {
      return 'Akun Anda tidak memiliki akses. Pastikan menggunakan akun Google yang benar.';
    }

    // Server errors
    if (lowerCaseError.contains('server') || 
        lowerCaseError.contains('500') ||
        lowerCaseError.contains('503') ||
        lowerCaseError.contains('502')) {
      return 'Server sedang bermasalah. Silakan coba beberapa saat lagi.';
    }

    // Rate limiting
    if (lowerCaseError.contains('too many') || 
        lowerCaseError.contains('rate limit') ||
        lowerCaseError.contains('429')) {
      return 'Terlalu banyak percobaan. Silakan tunggu sebentar sebelum mencoba lagi.';
    }

    // Generic authentication errors
    if (lowerCaseError.contains('auth') || 
        lowerCaseError.contains('login') ||
        lowerCaseError.contains('sign')) {
      return 'Gagal masuk ke akun. Periksa koneksi internet dan coba lagi.';
    }

    // Configuration errors (for developers)
    if (lowerCaseError.contains('client id') || 
        lowerCaseError.contains('configuration') ||
        lowerCaseError.contains('setup')) {
      return 'Aplikasi belum dikonfigurasi dengan benar. Silakan hubungi tim pengembang.';
    }

    // Default fallback message
    return 'Terjadi kesalahan saat masuk. Silakan periksa koneksi internet dan coba lagi.';
  }

  /// Get action suggestion based on error type
  static String getActionSuggestion(String? errorMessage) {
    if (errorMessage == null || errorMessage.isEmpty) {
      return 'Coba lagi';
    }

    final lowerCaseError = errorMessage.toLowerCase();

    if (lowerCaseError.contains('network') || 
        lowerCaseError.contains('connection') ||
        lowerCaseError.contains('timeout')) {
      return 'Periksa Koneksi';
    }

    if (lowerCaseError.contains('cancelled') || 
        lowerCaseError.contains('user_canceled')) {
      return 'Masuk Lagi';
    }

    if (lowerCaseError.contains('too many') || 
        lowerCaseError.contains('rate limit')) {
      return 'Tunggu Sebentar';
    }

    return 'Coba Lagi';
  }

  /// Check if error is recoverable (user can retry)
  static bool isRecoverableError(String? errorMessage) {
    if (errorMessage == null || errorMessage.isEmpty) {
      return true;
    }

    final lowerCaseError = errorMessage.toLowerCase();

    // Non-recoverable errors (configuration issues)
    if (lowerCaseError.contains('client id') || 
        lowerCaseError.contains('configuration') ||
        lowerCaseError.contains('setup')) {
      return false;
    }

    // Most other errors are recoverable
    return true;
  }
}