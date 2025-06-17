import 'package:flutter_test/flutter_test.dart';
import 'package:get_home_application_support_directory/get_home_application_support_directory.dart';
import 'package:get_home_application_support_directory/get_home_application_support_directory_platform_interface.dart';
import 'package:get_home_application_support_directory/get_home_application_support_directory_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGetHomeApplicationSupportDirectoryPlatform
    with MockPlatformInterfaceMixin
    implements GetHomeApplicationSupportDirectoryPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> getApplicationSupportDirectory() =>
      Future.value('/Users/testuser/Library/Application Support');
}

void main() {
  final GetHomeApplicationSupportDirectoryPlatform initialPlatform =
      GetHomeApplicationSupportDirectoryPlatform.instance;

  test(
    '$MethodChannelGetHomeApplicationSupportDirectory is the default instance',
    () {
      expect(
        initialPlatform,
        isInstanceOf<MethodChannelGetHomeApplicationSupportDirectory>(),
      );
    },
  );

  test('getPlatformVersion', () async {
    GetHomeApplicationSupportDirectory
    getHomeApplicationSupportDirectoryPlugin =
        GetHomeApplicationSupportDirectory();
    MockGetHomeApplicationSupportDirectoryPlatform fakePlatform =
        MockGetHomeApplicationSupportDirectoryPlatform();
    GetHomeApplicationSupportDirectoryPlatform.instance = fakePlatform;

    expect(
      await getHomeApplicationSupportDirectoryPlugin.getPlatformVersion(),
      '42',
    );
  });

  test('getApplicationSupportDirectory', () async {
    GetHomeApplicationSupportDirectory
    getHomeApplicationSupportDirectoryPlugin =
        GetHomeApplicationSupportDirectory();
    MockGetHomeApplicationSupportDirectoryPlatform fakePlatform =
        MockGetHomeApplicationSupportDirectoryPlatform();
    GetHomeApplicationSupportDirectoryPlatform.instance = fakePlatform;

    expect(
      await getHomeApplicationSupportDirectoryPlugin
          .getApplicationSupportDirectory(),
      '/Users/testuser/Library/Application Support',
    );
  });
}
