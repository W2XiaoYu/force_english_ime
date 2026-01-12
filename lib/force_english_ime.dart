
import 'force_english_ime_platform_interface.dart';

class ForceEnglishIme {
  Future<String?> getPlatformVersion() {
    return ForceEnglishImePlatform.instance.getPlatformVersion();
  }

  /// Check if the current input method is in English mode
  /// Returns true if the IME is in English mode (IME closed)
  Future<bool> isEnglishIme() {
    return ForceEnglishImePlatform.instance.isEnglishIme();
  }

  /// Force the input method to English mode by closing the IME
  /// Returns true if successful
  ///
  /// The original IME state will be saved automatically and can be restored
  /// using [restoreOriginalIme]
  Future<bool> forceEnglishInput() {
    return ForceEnglishImePlatform.instance.forceEnglishInput();
  }

  /// Restore the original input method state that was saved before
  /// calling [forceEnglishInput]
  /// Returns true if successful
  Future<bool> restoreOriginalIme() {
    return ForceEnglishImePlatform.instance.restoreOriginalIme();
  }
}
