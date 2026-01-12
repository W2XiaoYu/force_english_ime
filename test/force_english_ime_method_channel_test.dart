import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:force_english_ime/force_english_ime_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelForceEnglishIme platform = MethodChannelForceEnglishIme();
  const MethodChannel channel = MethodChannel('force_english_ime');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
