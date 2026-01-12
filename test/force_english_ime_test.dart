import 'package:flutter_test/flutter_test.dart';
import 'package:force_english_ime/force_english_ime.dart';
import 'package:force_english_ime/force_english_ime_platform_interface.dart';
import 'package:force_english_ime/force_english_ime_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockForceEnglishImePlatform
    with MockPlatformInterfaceMixin
    implements ForceEnglishImePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool> forceEnglishInput() {
    // TODO: implement forceEnglishInput
    throw UnimplementedError();
  }

  @override
  Future<bool> isEnglishIme() {
    // TODO: implement isEnglishIme
    throw UnimplementedError();
  }

  @override
  Future<bool> restoreOriginalIme() {
    // TODO: implement restoreOriginalIme
    throw UnimplementedError();
  }
}

void main() {
  final ForceEnglishImePlatform initialPlatform = ForceEnglishImePlatform.instance;

  test('$MethodChannelForceEnglishIme is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelForceEnglishIme>());
  });

  test('getPlatformVersion', () async {
    ForceEnglishIme forceEnglishImePlugin = ForceEnglishIme();
    MockForceEnglishImePlatform fakePlatform = MockForceEnglishImePlatform();
    ForceEnglishImePlatform.instance = fakePlatform;

    expect(await forceEnglishImePlugin.getPlatformVersion(), '42');
  });
}
