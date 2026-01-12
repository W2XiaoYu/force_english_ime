import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'force_english_ime_platform_interface.dart';

/// An implementation of [ForceEnglishImePlatform] that uses method channels.
class MethodChannelForceEnglishIme extends ForceEnglishImePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('force_english_ime');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> isEnglishIme() async {
    final result = await methodChannel.invokeMethod<bool>('isEnglishIme');
    return result ?? true;
  }

  @override
  Future<bool> forceEnglishInput() async {
    final result = await methodChannel.invokeMethod<bool>('forceEnglishInput');
    return result ?? false;
  }

  @override
  Future<bool> restoreOriginalIme() async {
    final result = await methodChannel.invokeMethod<bool>('restoreOriginalIme');
    return result ?? false;
  }
}
