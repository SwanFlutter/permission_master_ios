import 'package:flutter_test/flutter_test.dart';
import 'package:permission_master_ios/permission_master_ios.dart';
import 'package:permission_master_ios/permission_master_ios_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPermissionMasterIosPlatform
    with MockPlatformInterfaceMixin
    implements PermissionMasterIosPlatform {
  String _mockPermissionStatus = 'granted';
  bool _mockOpenSettingsResult = true;

  @override
  Future<String?> getPlatformVersion() => Future.value('iOS 17.0');

  @override
  Future<String> checkPermissionStatus(String permission) =>
      Future.value(_mockPermissionStatus);

  @override
  Future<String> requestCameraPermission() =>
      Future.value(_mockPermissionStatus);

  @override
  Future<String> requestPhotosPermission() =>
      Future.value(_mockPermissionStatus);

  @override
  Future<String> requestMicrophonePermission() =>
      Future.value(_mockPermissionStatus);

  @override
  Future<String> requestLocationPermission() =>
      Future.value(_mockPermissionStatus);

  @override
  Future<String> requestContactsPermission() =>
      Future.value(_mockPermissionStatus);

  @override
  Future<String> requestCalendarPermission() =>
      Future.value(_mockPermissionStatus);

  @override
  Future<String> requestRemindersPermission() =>
      Future.value(_mockPermissionStatus);

  @override
  Future<String> requestNotificationPermission() =>
      Future.value(_mockPermissionStatus);

  @override
  Future<String> requestBluetoothPermission() =>
      Future.value(_mockPermissionStatus);

  @override
  Future<String> requestMotionPermission() =>
      Future.value(_mockPermissionStatus);

  @override
  Future<String> requestSpeechPermission() =>
      Future.value(_mockPermissionStatus);

  @override
  Future<String> requestMusicPermission() =>
      Future.value(_mockPermissionStatus);

  @override
  Future<String> requestHealthPermission() =>
      Future.value(_mockPermissionStatus);

  @override
  Future<bool> openAppSettings() => Future.value(_mockOpenSettingsResult);

  void setMockPermissionStatus(String status) {
    _mockPermissionStatus = status;
  }

  void setMockOpenSettingsResult(bool result) {
    _mockOpenSettingsResult = result;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockPermissionMasterIosPlatform mockPlatform;
  late PermissionMasterIos plugin;

  setUp(() {
    mockPlatform = MockPermissionMasterIosPlatform();
    PermissionMasterIosPlatform.instance = mockPlatform;
    plugin = PermissionMasterIos();
  });

  group('Platform Version', () {
    test('getPlatformVersion returns iOS version', () async {
      final version = await plugin.getPlatformVersion();
      expect(version, 'iOS 17.0');
    });
  });

  group('Camera Permission', () {
    test('returns granted status', () async {
      mockPlatform.setMockPermissionStatus('granted');
      final status = await plugin.requestCameraPermission();
      expect(status, PermissionStatus.granted);
    });

    test('returns denied status', () async {
      mockPlatform.setMockPermissionStatus('denied');
      final status = await plugin.requestCameraPermission();
      expect(status, PermissionStatus.denied);
    });

    test('returns restricted status', () async {
      mockPlatform.setMockPermissionStatus('restricted');
      final status = await plugin.requestCameraPermission();
      expect(status, PermissionStatus.restricted);
    });
  });

  group('Photos Permission', () {
    test('returns granted status', () async {
      mockPlatform.setMockPermissionStatus('granted');
      final status = await plugin.requestPhotosPermission();
      expect(status, PermissionStatus.granted);
    });

    test('returns limited status', () async {
      mockPlatform.setMockPermissionStatus('limited');
      final status = await plugin.requestPhotosPermission();
      expect(status, PermissionStatus.limited);
    });
  });

  group('All 13 Permissions', () {
    test('Microphone permission works', () async {
      mockPlatform.setMockPermissionStatus('granted');
      expect(
        await plugin.requestMicrophonePermission(),
        PermissionStatus.granted,
      );
    });

    test('Location permission works', () async {
      mockPlatform.setMockPermissionStatus('granted');
      expect(
        await plugin.requestLocationPermission(),
        PermissionStatus.granted,
      );
    });

    test('Contacts permission works', () async {
      mockPlatform.setMockPermissionStatus('granted');
      expect(
        await plugin.requestContactsPermission(),
        PermissionStatus.granted,
      );
    });

    test('Calendar permission works', () async {
      mockPlatform.setMockPermissionStatus('granted');
      expect(
        await plugin.requestCalendarPermission(),
        PermissionStatus.granted,
      );
    });

    test('Reminders permission works', () async {
      mockPlatform.setMockPermissionStatus('granted');
      expect(
        await plugin.requestRemindersPermission(),
        PermissionStatus.granted,
      );
    });

    test('Notification permission works', () async {
      mockPlatform.setMockPermissionStatus('granted');
      expect(
        await plugin.requestNotificationPermission(),
        PermissionStatus.granted,
      );
    });

    test('Bluetooth permission works', () async {
      mockPlatform.setMockPermissionStatus('granted');
      expect(
        await plugin.requestBluetoothPermission(),
        PermissionStatus.granted,
      );
    });

    test('Motion permission works', () async {
      mockPlatform.setMockPermissionStatus('granted');
      expect(await plugin.requestMotionPermission(), PermissionStatus.granted);
    });

    test('Speech permission works', () async {
      mockPlatform.setMockPermissionStatus('granted');
      expect(await plugin.requestSpeechPermission(), PermissionStatus.granted);
    });

    test('Music permission works', () async {
      mockPlatform.setMockPermissionStatus('granted');
      expect(await plugin.requestMusicPermission(), PermissionStatus.granted);
    });

    test('Health permission works', () async {
      mockPlatform.setMockPermissionStatus('granted');
      expect(await plugin.requestHealthPermission(), PermissionStatus.granted);
    });
  });

  group('Check Permission Status', () {
    test('returns granted', () async {
      mockPlatform.setMockPermissionStatus('granted');
      final status = await plugin.checkPermissionStatus(PermissionType.camera);
      expect(status, PermissionStatus.granted);
    });

    test('returns denied', () async {
      mockPlatform.setMockPermissionStatus('denied');
      final status = await plugin.checkPermissionStatus(PermissionType.camera);
      expect(status, PermissionStatus.denied);
    });

    test('returns notDetermined', () async {
      mockPlatform.setMockPermissionStatus('notDetermined');
      final status = await plugin.checkPermissionStatus(PermissionType.camera);
      expect(status, PermissionStatus.notDetermined);
    });
  });

  group('Open App Settings', () {
    test('returns true on success', () async {
      mockPlatform.setMockOpenSettingsResult(true);
      final result = await plugin.openAppSettings();
      expect(result, true);
    });

    test('returns false on failure', () async {
      mockPlatform.setMockOpenSettingsResult(false);
      final result = await plugin.openAppSettings();
      expect(result, false);
    });
  });

  group('Permission Status Parsing', () {
    test('parses all statuses correctly', () async {
      mockPlatform.setMockPermissionStatus('granted');
      expect(await plugin.requestCameraPermission(), PermissionStatus.granted);

      mockPlatform.setMockPermissionStatus('denied');
      expect(await plugin.requestCameraPermission(), PermissionStatus.denied);

      mockPlatform.setMockPermissionStatus('restricted');
      expect(
        await plugin.requestCameraPermission(),
        PermissionStatus.restricted,
      );

      mockPlatform.setMockPermissionStatus('limited');
      expect(await plugin.requestPhotosPermission(), PermissionStatus.limited);

      mockPlatform.setMockPermissionStatus('unknown');
      expect(
        await plugin.requestCameraPermission(),
        PermissionStatus.notDetermined,
      );
    });
  });

  group('Storage', () {
    test('storage getter returns GetStorageBridge', () {
      final storage = plugin.storage;
      expect(storage, isNotNull);
      expect(storage, isA<GetStorageBridge>());
    });
  });

  group('Permission Types', () {
    test('all 13 permission types exist', () {
      expect(PermissionType.camera.value, 'camera');
      expect(PermissionType.photos.value, 'photos');
      expect(PermissionType.microphone.value, 'microphone');
      expect(PermissionType.location.value, 'location');
      expect(PermissionType.contacts.value, 'contacts');
      expect(PermissionType.calendar.value, 'calendar');
      expect(PermissionType.reminders.value, 'reminders');
      expect(PermissionType.notification.value, 'notification');
      expect(PermissionType.bluetooth.value, 'bluetooth');
      expect(PermissionType.motion.value, 'motion');
      expect(PermissionType.speech.value, 'speech');
      expect(PermissionType.music.value, 'music');
      expect(PermissionType.health.value, 'health');
    });
  });

  group('Permission Status Enum', () {
    test('all status values exist', () {
      expect(PermissionStatus.granted, isNotNull);
      expect(PermissionStatus.denied, isNotNull);
      expect(PermissionStatus.restricted, isNotNull);
      expect(PermissionStatus.limited, isNotNull);
      expect(PermissionStatus.notDetermined, isNotNull);
      expect(PermissionStatus.openSettings, isNotNull);
      expect(PermissionStatus.unsupported, isNotNull);
      expect(PermissionStatus.error, isNotNull);
    });
  });
}
