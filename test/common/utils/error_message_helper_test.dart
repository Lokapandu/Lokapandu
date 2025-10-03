import 'package:flutter_test/flutter_test.dart';
import 'package:lokapandu/common/utils/error_message_helper.dart';

void main() {
  group('ErrorMessageHelper', () {
    group('getReadableErrorMessage', () {
      test('should return default message for null input', () {
        final result = ErrorMessageHelper.getReadableErrorMessage(null);
        expect(result, 'Terjadi kesalahan yang tidak diketahui. Silakan coba lagi.');
      });

      test('should return default message for empty input', () {
        final result = ErrorMessageHelper.getReadableErrorMessage('');
        expect(result, 'Terjadi kesalahan yang tidak diketahui. Silakan coba lagi.');
      });

      test('should return network error message for network issues', () {
        final result = ErrorMessageHelper.getReadableErrorMessage('Network connection failed');
        expect(result, 'Koneksi internet bermasalah. Periksa koneksi Anda dan coba lagi.');
      });

      test('should return cancellation message for user cancelled errors', () {
        final result = ErrorMessageHelper.getReadableErrorMessage('Google Sign-In was cancelled by user');
        expect(result, 'Proses masuk dibatalkan. Silakan coba lagi jika ingin masuk.');
      });

      test('should return Google auth error message for Google sign-in issues', () {
        final result = ErrorMessageHelper.getReadableErrorMessage('Failed to obtain Google ID token');
        expect(result, 'Gagal mendapatkan akses dari Google. Silakan coba masuk lagi.');
      });

      test('should return server error message for server issues', () {
        final result = ErrorMessageHelper.getReadableErrorMessage('Server error 500');
        expect(result, 'Server sedang bermasalah. Silakan coba beberapa saat lagi.');
      });

      test('should return rate limit message for too many attempts', () {
        final result = ErrorMessageHelper.getReadableErrorMessage('Too many attempts');
        expect(result, 'Terlalu banyak percobaan. Silakan tunggu sebentar sebelum mencoba lagi.');
      });
    });

    group('getActionSuggestion', () {
      test('should return default action for null input', () {
        final result = ErrorMessageHelper.getActionSuggestion(null);
        expect(result, 'Coba lagi');
      });

      test('should return network action for network errors', () {
        final result = ErrorMessageHelper.getActionSuggestion('Network timeout');
        expect(result, 'Periksa Koneksi');
      });

      test('should return retry action for cancelled errors', () {
        final result = ErrorMessageHelper.getActionSuggestion('User cancelled');
        expect(result, 'Masuk Lagi');
      });

      test('should return wait action for rate limit errors', () {
        final result = ErrorMessageHelper.getActionSuggestion('Too many requests');
        expect(result, 'Tunggu Sebentar');
      });
    });

    group('isRecoverableError', () {
      test('should return true for null input', () {
        final result = ErrorMessageHelper.isRecoverableError(null);
        expect(result, true);
      });

      test('should return true for network errors', () {
        final result = ErrorMessageHelper.isRecoverableError('Network error');
        expect(result, true);
      });

      test('should return false for configuration errors', () {
        final result = ErrorMessageHelper.isRecoverableError('Client ID configuration error');
        expect(result, false);
      });

      test('should return true for most other errors', () {
        final result = ErrorMessageHelper.isRecoverableError('Authentication failed');
        expect(result, true);
      });
    });
  });
}