import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_home_application_support_directory/get_home_application_support_directory_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelGetHomeApplicationSupportDirectory platform = MethodChannelGetHomeApplicationSupportDirectory();
  const MethodChannel channel = MethodChannel('get_home_application_support_directory');

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
