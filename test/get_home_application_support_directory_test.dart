import 'package:flutter_test/flutter_test.dart';
import 'package:get_home_application_support_directory/get_home_application_support_directory.dart';
import 'package:get_home_application_support_directory/get_home_application_support_directory_platform_interface.dart';
import 'package:get_home_application_support_directory/get_home_application_support_directory_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGetHomeApplicationSupportDirectoryPlatform
    with MockPlatformInterfaceMixin
    implements GetHomeApplicationSupportDirectoryPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('macOS 14.0');

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

  group('GetHomeApplicationSupportDirectory', () {
    late GetHomeApplicationSupportDirectory plugin;
    late GetHomeApplicationSupportDirectoryPlatform mockPlatform;

    setUp(() {
      plugin = GetHomeApplicationSupportDirectory();
      mockPlatform = MockGetHomeApplicationSupportDirectoryPlatform();
      GetHomeApplicationSupportDirectoryPlatform.instance = mockPlatform;
    });

    test('getPlatformVersion returns correct version', () async {
      final version = await plugin.getPlatformVersion();
      expect(version, 'macOS 14.0');
    });

    test('getApplicationSupportDirectory returns correct path', () async {
      final path = await plugin.getApplicationSupportDirectory();
      expect(path, '/Users/testuser/Library/Application Support');
    });

    test('isSupported returns boolean value', () {
      expect(GetHomeApplicationSupportDirectory.isSupported, isA<bool>());
    });

    group('createSubdirectory', () {
      test(
        'returns null when platform is not supported and plugin returns null',
        () async {
          // Mock the platform to return null
          mockPlatform = MockGetHomeApplicationSupportDirectoryPlatformNull();
          GetHomeApplicationSupportDirectoryPlatform.instance = mockPlatform;

          final result = await plugin.createSubdirectory('TestApp');
          expect(result, isNull);
        },
      );

      test('handles subdirectory name validation', () {
        // Test that the method accepts various subdirectory names
        expect(() => plugin.createSubdirectory('TestApp'), returnsNormally);
        expect(() => plugin.createSubdirectory(''), returnsNormally);
        expect(
          () => plugin.createSubdirectory('TestApp/SubDir'),
          returnsNormally,
        );
      });

      test('handles recursive parameter properly', () {
        // Test that the method accepts the recursive parameter
        expect(
          () => plugin.createSubdirectory('TestApp', recursive: true),
          returnsNormally,
        );
        expect(
          () => plugin.createSubdirectory('TestApp', recursive: false),
          returnsNormally,
        );
      });
    });
  });
}

// Mock that returns null for testing null path scenarios
class MockGetHomeApplicationSupportDirectoryPlatformNull
    with MockPlatformInterfaceMixin
    implements GetHomeApplicationSupportDirectoryPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('macOS 14.0');

  @override
  Future<String?> getApplicationSupportDirectory() => Future.value(null);
}
