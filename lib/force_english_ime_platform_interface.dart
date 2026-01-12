import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'force_english_ime_method_channel.dart';

abstract class ForceEnglishImePlatform extends PlatformInterface {
  /// Constructs a ForceEnglishImePlatform.
  ForceEnglishImePlatform() : super(token: _token);

  static final Object _token = Object();

  static ForceEnglishImePlatform _instance = MethodChannelForceEnglishIme();

  /// The default instance of [ForceEnglishImePlatform] to use.
  ///
  /// Defaults to [MethodChannelForceEnglishIme].
  static ForceEnglishImePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ForceEnglishImePlatform] when
  /// they register themselves.
  static set instance(ForceEnglishImePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// Check if the current input method is in English mode
  Future<bool> isEnglishIme() {
    throw UnimplementedError('isEnglishIme() has not been implemented.');
  }

  /// Force the input method to English mode
  /// Returns true if successful
  Future<bool> forceEnglishInput() {
    throw UnimplementedError('forceEnglishInput() has not been implemented.');
  }

  /// Restore the original input method state
  /// Returns true if successful
  Future<bool> restoreOriginalIme() {
    throw UnimplementedError('restoreOriginalIme() has not been implemented.');
  }
}
