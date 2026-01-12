/// A Windows plugin for Flutter that forces English input mode by controlling
/// the Input Method Editor (IME) state.
///
/// This plugin completely disables IME to prevent users from switching input
/// methods via shortcuts (like Shift, Ctrl+Space, etc.).
///
/// ## Features
///
/// - Complete IME disable using `ImmAssociateContext`
/// - Automatic state save and restore
/// - Accurate input mode detection
/// - Zero external dependencies
///
/// ## Usage
///
/// ```dart
/// import 'package:force_english_ime/force_english_ime.dart';
///
/// final imePlugin = ForceEnglishIme();
///
/// // Force English input when TextField gains focus
/// await imePlugin.forceEnglishInput();
///
/// // Restore original IME when TextField loses focus
/// await imePlugin.restoreOriginalIme();
/// ```
library force_english_ime;

import 'force_english_ime_platform_interface.dart';

/// Main class for controlling IME (Input Method Editor) state on Windows.
///
/// This class provides methods to force English input mode and manage IME state.
class ForceEnglishIme {
  /// Gets the platform version string.
  ///
  /// Returns a string describing the Windows version, e.g., "Windows 10+".
  /// This method is mainly used for debugging purposes.
  ///
  /// Example:
  /// ```dart
  /// final version = await ForceEnglishIme().getPlatformVersion();
  /// print(version); // "Windows 10+"
  /// ```
  Future<String?> getPlatformVersion() {
    return ForceEnglishImePlatform.instance.getPlatformVersion();
  }

  /// Checks if the current input method is in English mode.
  ///
  /// Returns `true` if the IME is in English/alphanumeric mode (IME closed),
  /// or `false` if in Chinese/IME mode.
  ///
  /// This method uses Windows IMM API `ImmGetConversionStatus` to accurately
  /// detect the current input mode.
  ///
  /// Example:
  /// ```dart
  /// final isEnglish = await ForceEnglishIme().isEnglishIme();
  /// if (isEnglish) {
  ///   print('Currently in English mode');
  /// }
  /// ```
  Future<bool> isEnglishIme() {
    return ForceEnglishImePlatform.instance.isEnglishIme();
  }

  /// Forces the input method to English mode by completely disabling IME.
  ///
  /// This method disables IME using Windows IMM API `ImmAssociateContext`,
  /// which prevents users from switching input methods via any keyboard
  /// shortcuts (Shift, Ctrl+Space, etc.).
  ///
  /// The original IME state is automatically saved and can be restored
  /// using [restoreOriginalIme].
  ///
  /// Returns `true` if successful, `false` otherwise (e.g., no focused control).
  ///
  /// Example:
  /// ```dart
  /// Focus(
  ///   onFocusChange: (hasFocus) {
  ///     if (hasFocus) {
  ///       ForceEnglishIme().forceEnglishInput();
  ///     }
  ///   },
  ///   child: TextField(
  ///     decoration: InputDecoration(labelText: 'Email'),
  ///   ),
  /// )
  /// ```
  Future<bool> forceEnglishInput() {
    return ForceEnglishImePlatform.instance.forceEnglishInput();
  }

  /// Restores the original input method state.
  ///
  /// This method restores the IME state that was saved before calling
  /// [forceEnglishInput]. It should be called when the input field loses
  /// focus to return the user's original input method.
  ///
  /// Returns `true` if successful, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// Focus(
  ///   onFocusChange: (hasFocus) {
  ///     if (!hasFocus) {
  ///       ForceEnglishIme().restoreOriginalIme();
  ///     }
  ///   },
  ///   child: TextField(
  ///     decoration: InputDecoration(labelText: 'Email'),
  ///   ),
  /// )
  /// ```
  Future<bool> restoreOriginalIme() {
    return ForceEnglishImePlatform.instance.restoreOriginalIme();
  }
}
