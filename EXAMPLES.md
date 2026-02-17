# نمونه کدهای کاربردی - Permission Master iOS

این فایل شامل مثال‌های عملی و کامل برای تمام 13 مجوز iOS است.

## فهرست

1. [📷 Camera Permission](#1--camera-permission)
2. [🖼️ Photos Permission](#2--photos-permission)
3. [🎤 Microphone Permission](#3--microphone-permission)
4. [📍 Location Permission](#4--location-permission)
5. [🔔 Notifications Permission](#5--notifications-permission)
6. [👥 Contacts Permission](#6--contacts-permission)
7. [📅 Calendar Permission](#7--calendar-permission)
8. [⏰ Reminders Permission](#8--reminders-permission)
9. [📶 Bluetooth Permission](#9--bluetooth-permission)
10. [🏃 Motion & Fitness Permission](#10--motion--fitness-permission)
11. [🗣️ Speech Recognition Permission](#11--speech-recognition-permission)
12. [🎵 Media Library Permission](#12--media-library-permission)
13. [❤️ Health Data Permission](#13--health-data-permission)
14. [💾 Storage Examples](#14--storage-examples)
15. [🎯 Complete App Example](#15--complete-app-example)

---

## 1. 📷 Camera Permission

### مثال ساده

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

Future<void> takePicture() async {
  final plugin = PermissionMasterIos();
  
  final status = await plugin.requestCameraPermission();
  
  if (status == PermissionStatus.granted) {
    print('✅ Camera permission granted - can capture photos/videos');
    // TODO: Open camera
  } else if (status == PermissionStatus.denied) {
    print('❌ Camera permission denied');
  } else if (status == PermissionStatus.restricted) {
    print('⚠️ Camera access restricted by device settings');
  }
}
```

### مثال پیشرفته با UI

```dart
import 'package:flutter/material.dart';
import 'package:permission_master_ios/permission_master_ios.dart';

class CameraPermissionWidget extends StatefulWidget {
  const CameraPermissionWidget({super.key});

  @override
  State<CameraPermissionWidget> createState() => _CameraPermissionWidgetState();
}

class _CameraPermissionWidgetState extends State<CameraPermissionWidget> {
  final _plugin = PermissionMasterIos();
  PermissionStatus? _cameraStatus;

  @override
  void initState() {
    super.initState();
    _checkCameraStatus();
  }

  Future<void> _checkCameraStatus() async {
    final status = await _plugin.checkPermissionStatus(PermissionType.camera);
    setState(() => _cameraStatus = status);
  }

  Future<void> _requestCamera() async {
    final status = await _plugin.requestCameraPermission();
    setState(() => _cameraStatus = status);

    if (status == PermissionStatus.granted) {
      _openCamera();
    } else {
      _showPermissionDialog();
    }
  }

  void _openCamera() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('📷 Opening camera...')),
    );
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Camera Permission Required'),
        content: const Text(
          'This app needs camera access to take photos. '
          'Please grant permission in Settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              // Open app settings
              await _plugin.openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.camera_alt,
          size: 64,
          color: _cameraStatus == PermissionStatus.granted
              ? Colors.green
              : Colors.grey,
        ),
        const SizedBox(height: 16),
        Text('Status: ${_cameraStatus?.name ?? "Unknown"}'),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: _requestCamera,
          icon: const Icon(Icons.camera),
          label: const Text('Request Camera'),
        ),
      ],
    );
  }
}
```

---

## 2. 🖼️ Photos Permission

### مثال ساده

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

Future<void> selectPhoto() async {
  final plugin = PermissionMasterIos();
  
  final status = await plugin.requestPhotosPermission();
  
  if (status == PermissionStatus.granted) {
    print('✅ Full photo library access granted');
    // TODO: Open photo picker with full access
  } else if (status == PermissionStatus.limited) {
    print('⚠️ Limited photo library access (iOS 14+)');
    // TODO: Open photo picker with limited access
  } else if (status == PermissionStatus.denied) {
    print('❌ Photo library access denied');
  }
}
```

### مثال با مدیریت Limited Access

```dart
Future<void> handlePhotosPermission() async {
  final plugin = PermissionMasterIos();
  
  final status = await plugin.requestPhotosPermission();
  
  switch (status) {
    case PermissionStatus.granted:
      print('Full access to photo library');
      // User can select any photo
      break;
      
    case PermissionStatus.limited:
      print('Limited access - user selected specific photos');
      // Show option to select more photos
      _showLimitedAccessDialog();
      break;
      
    case PermissionStatus.denied:
      print('Access denied');
      _showPermissionDeniedDialog();
      break;
      
    default:
      print('Permission not determined');
  }
}

void _showLimitedAccessDialog() {
  // Show dialog explaining limited access
  // Offer option to select more photos
}

void _showPermissionDeniedDialog() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Photos Access Required'),
      content: const Text(
        'Please enable photo library access in Settings to use this feature.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            await PermissionMasterIos().openAppSettings();
          },
          child: const Text('Open Settings'),
        ),
      ],
    ),
  );
}
```

---

## 3. 🎤 Microphone Permission

### مثال ساده

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

Future<void> startRecording() async {
  final plugin = PermissionMasterIos();
  
  final status = await plugin.requestMicrophonePermission();
  
  if (status == PermissionStatus.granted) {
    print('✅ Microphone permission granted - can record audio');
    // TODO: Start audio recording
  } else if (status == PermissionStatus.denied) {
    print('❌ Microphone permission denied');
  }
}
```

### مثال با Voice Recorder

```dart
class VoiceRecorder {
  final _plugin = PermissionMasterIos();
  bool _isRecording = false;

  Future<bool> startRecording() async {
    if (_isRecording) return false;

    final status = await _plugin.requestMicrophonePermission();
    
    if (status == PermissionStatus.granted) {
      _isRecording = true;
      print('🎤 Recording started...');
      // TODO: Implement actual recording logic
      return true;
    } else {
      print('❌ Cannot record - permission denied');
      return false;
    }
  }

  void stopRecording() {
    if (_isRecording) {
      _isRecording = false;
      print('⏹️ Recording stopped');
      // TODO: Save recording
    }
  }
}

// Usage
final recorder = VoiceRecorder();
await recorder.startRecording();
// ... record audio ...
recorder.stopRecording();
```

---

## 4. 📍 Location Permission

### مثال ساده

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

Future<void> getCurrentLocation() async {
  final plugin = PermissionMasterIos();
  
  final status = await plugin.requestLocationPermission();
  
  if (status == PermissionStatus.granted) {
    print('✅ Location permission granted - can access GPS');
    // TODO: Get user location
  } else if (status == PermissionStatus.denied) {
    print('❌ Location permission denied');
  }
}
```

### مثال با Location Tracking

```dart
class LocationTracker {
  final _plugin = PermissionMasterIos();

  Future<Map<String, double>?> getCurrentPosition() async {
    final status = await _plugin.requestLocationPermission();
    
    if (status == PermissionStatus.granted) {
      print('📍 Getting current location...');
      // TODO: Implement location fetching
      // Return latitude and longitude
      return {
        'latitude': 35.6892,
        'longitude': 51.3890,
      };
    } else if (status == PermissionStatus.denied) {
      print('❌ Location access denied');
      return null;
    }
    
    return null;
  }

  Future<void> startLocationUpdates() async {
    final status = await _plugin.requestLocationPermission();
    
    if (status == PermissionStatus.granted) {
      print('📍 Starting location updates...');
      // TODO: Start continuous location updates
    }
  }
}

// Usage
final tracker = LocationTracker();
final position = await tracker.getCurrentPosition();
if (position != null) {
  print('Lat: ${position['latitude']}, Lng: ${position['longitude']}');
}
```

---

## 5. 🔔 Notifications Permission

### مثال ساده

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

Future<void> setupNotifications() async {
  final plugin = PermissionMasterIos();
  
  final status = await plugin.requestNotificationPermission();
  
  if (status == PermissionStatus.granted) {
    print('✅ Notification permission granted - can send push notifications');
    // TODO: Setup push notifications
  } else if (status == PermissionStatus.denied) {
    print('❌ Notification permission denied');
  }
}
```

### مثال با Notification Manager

```dart
class NotificationManager {
  final _plugin = PermissionMasterIos();
  bool _isEnabled = false;

  Future<bool> initialize() async {
    final status = await _plugin.requestNotificationPermission();
    
    if (status == PermissionStatus.granted) {
      _isEnabled = true;
      print('🔔 Notifications enabled');
      // TODO: Register for remote notifications
      return true;
    } else {
      _isEnabled = false;
      print('❌ Notifications disabled');
      return false;
    }
  }

  Future<void> sendLocalNotification({
    required String title,
    required String body,
  }) async {
    if (!_isEnabled) {
      print('⚠️ Notifications not enabled');
      return;
    }

    print('📬 Sending notification: $title');
    // TODO: Send local notification
  }
}

// Usage
final notificationManager = NotificationManager();
await notificationManager.initialize();
await notificationManager.sendLocalNotification(
  title: 'Hello',
  body: 'This is a test notification',
);
```

---

## 6. 👥 Contacts Permission

### مثال ساده

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

Future<void> loadContacts() async {
  final plugin = PermissionMasterIos();
  
  final status = await plugin.requestContactsPermission();
  
  if (status == PermissionStatus.granted) {
    print('✅ Contacts permission granted - can read/write contacts');
    // TODO: Load contacts from device
  } else if (status == PermissionStatus.denied) {
    print('❌ Contacts permission denied');
  }
}
```

### مثال با Contact Manager

```dart
class ContactManager {
  final _plugin = PermissionMasterIos();

  Future<List<Map<String, String>>> getAllContacts() async {
    final status = await _plugin.requestContactsPermission();
    
    if (status == PermissionStatus.granted) {
      print('👥 Loading contacts...');
      // TODO: Fetch contacts from device
      return [
        {'name': 'Ali', 'phone': '+98 912 345 6789'},
        {'name': 'Sara', 'phone': '+98 912 987 6543'},
      ];
    } else {
      print('❌ Cannot access contacts');
      return [];
    }
  }

  Future<bool> addContact({
    required String name,
    required String phone,
  }) async {
    final status = await _plugin.requestContactsPermission();
    
    if (status == PermissionStatus.granted) {
      print('➕ Adding contact: $name');
      // TODO: Add contact to device
      return true;
    }
    
    return false;
  }
}

// Usage
final contactManager = ContactManager();
final contacts = await contactManager.getAllContacts();
print('Found ${contacts.length} contacts');

await contactManager.addContact(
  name: 'John Doe',
  phone: '+1 234 567 8900',
);
```

---

## 7. 📅 Calendar Permission

### مثال ساده

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

Future<void> addCalendarEvent() async {
  final plugin = PermissionMasterIos();
  
  final status = await plugin.requestCalendarPermission();
  
  if (status == PermissionStatus.granted) {
    print('✅ Calendar permission granted - can manage events');
    // TODO: Add event to calendar
  } else if (status == PermissionStatus.denied) {
    print('❌ Calendar permission denied');
  }
}
```

### مثال با Calendar Manager

```dart
class CalendarManager {
  final _plugin = PermissionMasterIos();

  Future<bool> createEvent({
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    String? notes,
  }) async {
    final status = await _plugin.requestCalendarPermission();
    
    if (status == PermissionStatus.granted) {
      print('📅 Creating calendar event: $title');
      // TODO: Create event in calendar
      return true;
    } else {
      print('❌ Cannot create event - permission denied');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getEvents({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final status = await _plugin.requestCalendarPermission();
    
    if (status == PermissionStatus.granted) {
      print('📅 Fetching events...');
      // TODO: Fetch events from calendar
      return [
        {
          'title': 'Meeting',
          'start': DateTime.now(),
          'end': DateTime.now().add(const Duration(hours: 1)),
        },
      ];
    }
    
    return [];
  }
}

// Usage
final calendar = CalendarManager();
await calendar.createEvent(
  title: 'Team Meeting',
  startDate: DateTime.now(),
  endDate: DateTime.now().add(const Duration(hours: 2)),
  notes: 'Discuss project updates',
);
```

---

## 8. ⏰ Reminders Permission

### مثال ساده

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

Future<void> createReminder() async {
  final plugin = PermissionMasterIos();
  
  final status = await plugin.requestRemindersPermission();
  
  if (status == PermissionStatus.granted) {
    print('✅ Reminders permission granted - can create reminders');
    // TODO: Create reminder
  } else if (status == PermissionStatus.denied) {
    print('❌ Reminders permission denied');
  }
}
```

### مثال با Reminder Manager

```dart
class ReminderManager {
  final _plugin = PermissionMasterIos();

  Future<bool> addReminder({
    required String title,
    DateTime? dueDate,
    String? notes,
    bool isCompleted = false,
  }) async {
    final status = await _plugin.requestRemindersPermission();
    
    if (status == PermissionStatus.granted) {
      print('⏰ Creating reminder: $title');
      // TODO: Add reminder to iOS Reminders app
      return true;
    } else {
      print('❌ Cannot create reminder - permission denied');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getReminders() async {
    final status = await _plugin.requestRemindersPermission();
    
    if (status == PermissionStatus.granted) {
      print('⏰ Fetching reminders...');
      // TODO: Fetch reminders
      return [
        {
          'title': 'Buy groceries',
          'dueDate': DateTime.now().add(const Duration(days: 1)),
          'isCompleted': false,
        },
      ];
    }
    
    return [];
  }
}

// Usage
final reminderManager = ReminderManager();
await reminderManager.addReminder(
  title: 'Call dentist',
  dueDate: DateTime.now().add(const Duration(days: 2)),
  notes: 'Schedule appointment',
);
```

---

## 9. 📶 Bluetooth Permission

### مثال ساده

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

Future<void> connectBluetooth() async {
  final plugin = PermissionMasterIos();
  
  final status = await plugin.requestBluetoothPermission();
  
  if (status == PermissionStatus.granted) {
    print('✅ Bluetooth permission granted - can connect to devices');
    // TODO: Scan for Bluetooth devices
  } else if (status == PermissionStatus.denied) {
    print('❌ Bluetooth permission denied');
  }
}
```

### مثال با Bluetooth Manager

```dart
class BluetoothManager {
  final _plugin = PermissionMasterIos();
  bool _isScanning = false;

  Future<bool> startScanning() async {
    final status = await _plugin.requestBluetoothPermission();
    
    if (status == PermissionStatus.granted) {
      _isScanning = true;
      print('📶 Scanning for Bluetooth devices...');
      // TODO: Start Bluetooth scanning
      return true;
    } else {
      print('❌ Cannot scan - Bluetooth permission denied');
      return false;
    }
  }

  void stopScanning() {
    if (_isScanning) {
      _isScanning = false;
      print('⏹️ Stopped scanning');
    }
  }

  Future<List<String>> getConnectedDevices() async {
    final status = await _plugin.requestBluetoothPermission();
    
    if (status == PermissionStatus.granted) {
      print('📶 Getting connected devices...');
      // TODO: Get list of connected Bluetooth devices
      return ['Device 1', 'Device 2'];
    }
    
    return [];
  }
}

// Usage
final bluetooth = BluetoothManager();
await bluetooth.startScanning();
await Future.delayed(const Duration(seconds: 5));
bluetooth.stopScanning();

final devices = await bluetooth.getConnectedDevices();
print('Connected devices: $devices');
```

---

## 10. 🏃 Motion & Fitness Permission

### مثال ساده

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

Future<void> trackActivity() async {
  final plugin = PermissionMasterIos();
  
  final status = await plugin.requestMotionPermission();
  
  if (status == PermissionStatus.granted) {
    print('✅ Motion permission granted - can track physical activity');
    // TODO: Start tracking motion/fitness data
  } else if (status == PermissionStatus.denied) {
    print('❌ Motion permission denied');
  }
}
```

### مثال با Fitness Tracker

```dart
class FitnessTracker {
  final _plugin = PermissionMasterIos();
  bool _isTracking = false;

  Future<bool> startTracking() async {
    final status = await _plugin.requestMotionPermission();
    
    if (status == PermissionStatus.granted) {
      _isTracking = true;
      print('🏃 Started tracking activity...');
      // TODO: Start motion tracking
      return true;
    } else {
      print('❌ Cannot track - Motion permission denied');
      return false;
    }
  }

  void stopTracking() {
    if (_isTracking) {
      _isTracking = false;
      print('⏹️ Stopped tracking');
    }
  }

  Future<Map<String, dynamic>> getActivityData() async {
    final status = await _plugin.requestMotionPermission();
    
    if (status == PermissionStatus.granted) {
      print('🏃 Getting activity data...');
      // TODO: Fetch motion/fitness data
      return {
        'steps': 5000,
        'distance': 3.5, // km
        'calories': 250,
        'activeMinutes': 45,
      };
    }
    
    return {};
  }
}

// Usage
final tracker = FitnessTracker();
await tracker.startTracking();

// Later...
final data = await tracker.getActivityData();
print('Steps: ${data['steps']}');
print('Distance: ${data['distance']} km');
print('Calories: ${data['calories']}');
```

---

## 11. 🗣️ Speech Recognition Permission

### مثال ساده

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

Future<void> startSpeechRecognition() async {
  final plugin = PermissionMasterIos();
  
  final status = await plugin.requestSpeechPermission();
  
  if (status == PermissionStatus.granted) {
    print('✅ Speech recognition permission granted - can convert speech to text');
    // TODO: Start speech recognition
  } else if (status == PermissionStatus.denied) {
    print('❌ Speech recognition permission denied');
  }
}
```

### مثال با Speech Recognizer

```dart
class SpeechRecognizer {
  final _plugin = PermissionMasterIos();
  bool _isListening = false;
  String _recognizedText = '';

  Future<bool> startListening() async {
    final status = await _plugin.requestSpeechPermission();
    
    if (status == PermissionStatus.granted) {
      _isListening = true;
      _recognizedText = '';
      print('🗣️ Listening...');
      // TODO: Start speech recognition
      return true;
    } else {
      print('❌ Cannot listen - Speech permission denied');
      return false;
    }
  }

  void stopListening() {
    if (_isListening) {
      _isListening = false;
      print('⏹️ Stopped listening');
      print('Recognized text: $_recognizedText');
    }
  }

  Future<String?> recognizeSpeech({Duration timeout = const Duration(seconds: 10)}) async {
    final status = await _plugin.requestSpeechPermission();
    
    if (status == PermissionStatus.granted) {
      print('🗣️ Starting speech recognition...');
      // TODO: Implement speech recognition
      await Future.delayed(timeout);
      return 'Sample recognized text';
    }
    
    return null;
  }
}

// Usage
final recognizer = SpeechRecognizer();
await recognizer.startListening();
await Future.delayed(const Duration(seconds: 5));
recognizer.stopListening();

// Or one-shot recognition
final text = await recognizer.recognizeSpeech();
print('You said: $text');
```

---

## 12. 🎵 Media Library Permission

### مثال ساده

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

Future<void> accessMusicLibrary() async {
  final plugin = PermissionMasterIos();
  
  final status = await plugin.requestMusicPermission();
  
  if (status == PermissionStatus.granted) {
    print('✅ Media library permission granted - can access music');
    // TODO: Access music library
  } else if (status == PermissionStatus.denied) {
    print('❌ Media library permission denied');
  }
}
```

### مثال با Music Player

```dart
class MusicPlayer {
  final _plugin = PermissionMasterIos();
  bool _isPlaying = false;

  Future<List<Map<String, String>>> getMusicLibrary() async {
    final status = await _plugin.requestMusicPermission();
    
    if (status == PermissionStatus.granted) {
      print('🎵 Loading music library...');
      // TODO: Fetch music from library
      return [
        {'title': 'Song 1', 'artist': 'Artist 1', 'album': 'Album 1'},
        {'title': 'Song 2', 'artist': 'Artist 2', 'album': 'Album 2'},
      ];
    } else {
      print('❌ Cannot access music library');
      return [];
    }
  }

  Future<bool> playSong(String songId) async {
    final status = await _plugin.requestMusicPermission();
    
    if (status == PermissionStatus.granted) {
      _isPlaying = true;
      print('▶️ Playing song: $songId');
      // TODO: Play music
      return true;
    }
    
    return false;
  }

  void stopPlayback() {
    if (_isPlaying) {
      _isPlaying = false;
      print('⏹️ Stopped playback');
    }
  }
}

// Usage
final player = MusicPlayer();
final library = await player.getMusicLibrary();
print('Found ${library.length} songs');

if (library.isNotEmpty) {
  await player.playSong('song_id_1');
  await Future.delayed(const Duration(seconds: 5));
  player.stopPlayback();
}
```

---

## 13. ❤️ Health Data Permission

### مثال ساده

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

Future<void> accessHealthData() async {
  final plugin = PermissionMasterIos();
  
  final status = await plugin.requestHealthPermission();
  
  if (status == PermissionStatus.granted) {
    print('✅ Health data permission granted - can read/write health data');
    // TODO: Access HealthKit data
  } else if (status == PermissionStatus.denied) {
    print('❌ Health data permission denied');
  } else if (status == PermissionStatus.restricted) {
    print('⚠️ Health data not available on this device');
  }
}
```

### مثال با Health Manager

```dart
class HealthManager {
  final _plugin = PermissionMasterIos();

  Future<Map<String, dynamic>?> getHealthData() async {
    final status = await _plugin.requestHealthPermission();
    
    if (status == PermissionStatus.granted) {
      print('❤️ Reading health data...');
      // TODO: Read from HealthKit
      return {
        'steps': 8500,
        'heartRate': 72, // bpm
        'calories': 450,
        'distance': 6.2, // km
        'sleepHours': 7.5,
      };
    } else if (status == PermissionStatus.restricted) {
      print('⚠️ HealthKit not available on this device');
      return null;
    } else {
      print('❌ Cannot access health data');
      return null;
    }
  }

  Future<bool> writeWorkout({
    required String type,
    required Duration duration,
    required double calories,
  }) async {
    final status = await _plugin.requestHealthPermission();
    
    if (status == PermissionStatus.granted) {
      print('❤️ Writing workout data...');
      // TODO: Write to HealthKit
      return true;
    }
    
    return false;
  }
}

// Usage
final health = HealthManager();
final data = await health.getHealthData();

if (data != null) {
  print('Steps today: ${data['steps']}');
  print('Heart rate: ${data['heartRate']} bpm');
  print('Calories burned: ${data['calories']}');
}

await health.writeWorkout(
  type: 'Running',
  duration: const Duration(minutes: 30),
  calories: 250,
);
```

---

## 14. 💾 Storage Examples

### مثال ساده

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

Future<void> useStorage() async {
  final plugin = PermissionMasterIos();
  final storage = plugin.storage;
  
  // Write data
  await storage.write('username', 'Ali');
  await storage.write('age', 25);
  await storage.write('isLoggedIn', true);
  
  // Read data
  final username = await storage.read('username', 'Guest');
  final age = await storage.read('age', 0);
  final isLoggedIn = await storage.read('isLoggedIn', false);
  
  print('Username: $username');
  print('Age: $age');
  print('Logged in: $isLoggedIn');
}
```

### ذخیره تنظیمات کاربر

```dart
class UserPreferences {
  final storage = PermissionMasterIos().storage;
  
  Future<void> savePreferences({
    required String theme,
    required String language,
    required bool notifications,
    required double fontSize,
  }) async {
    await storage.write('pref_theme', theme);
    await storage.write('pref_language', language);
    await storage.write('pref_notifications', notifications);
    await storage.write('pref_fontSize', fontSize);
    print('✅ Preferences saved');
  }
  
  Future<Map<String, dynamic>> loadPreferences() async {
    return {
      'theme': await storage.read('pref_theme', 'light'),
      'language': await storage.read('pref_language', 'en'),
      'notifications': await storage.read('pref_notifications', true),
      'fontSize': await storage.read('pref_fontSize', 14.0),
    };
  }
  
  Future<void> resetToDefaults() async {
    await storage.remove('pref_theme');
    await storage.remove('pref_language');
    await storage.remove('pref_notifications');
    await storage.remove('pref_fontSize');
    print('🔄 Reset to defaults');
  }
}

// Usage
final prefs = UserPreferences();

await prefs.savePreferences(
  theme: 'dark',
  language: 'fa',
  notifications: true,
  fontSize: 16.0,
);

final settings = await prefs.loadPreferences();
print('Theme: ${settings['theme']}');
print('Language: ${settings['language']}');
```

### ذخیره وضعیت مجوزها

```dart
class PermissionCache {
  final storage = PermissionMasterIos().storage;
  
  Future<void> cachePermissionStatus(
    String permission,
    PermissionStatus status,
  ) async {
    await storage.write('perm_$permission', status.name);
    await storage.write(
      'perm_${permission}_time',
      DateTime.now().millisecondsSinceEpoch,
    );
    print('💾 Cached $permission: ${status.name}');
  }
  
  Future<String?> getCachedStatus(String permission) async {
    return await storage.read('perm_$permission', null);
  }
  
  Future<bool> isCacheValid(
    String permission, {
    Duration maxAge = const Duration(hours: 1),
  }) async {
    final timestamp = await storage.read('perm_${permission}_time', 0);
    if (timestamp == 0) return false;
    
    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    
    return now.difference(cacheTime) < maxAge;
  }
  
  Future<void> clearCache() async {
    // Clear all permission cache
    await storage.clear();
    print('🧹 Cache cleared');
  }
}

// Usage
final cache = PermissionCache();

// Cache permission status
await cache.cachePermissionStatus('camera', PermissionStatus.granted);

// Check cache
final cachedStatus = await cache.getCachedStatus('camera');
print('Cached camera status: $cachedStatus');

// Check if cache is still valid
final isValid = await cache.isCacheValid('camera');
print('Cache valid: $isValid');
```

### ذخیره داده‌های پیچیده

```dart
class AppDataManager {
  final storage = PermissionMasterIos().storage;
  
  Future<void> saveUserProfile({
    required String name,
    required String email,
    required Map<String, dynamic> settings,
    required List<String> favorites,
  }) async {
    await storage.write('user_name', name);
    await storage.write('user_email', email);
    await storage.write('user_settings', settings);
    
    // Store list as comma-separated string
    await storage.write('user_favorites', favorites.join(','));
    
    print('✅ User profile saved');
  }
  
  Future<Map<String, dynamic>?> loadUserProfile() async {
    final hasProfile = await storage.contains('user_name');
    if (!hasProfile) return null;
    
    final favoritesString = await storage.read('user_favorites', '');
    final favorites = favoritesString.isEmpty 
        ? <String>[]
        : favoritesString.split(',');
    
    return {
      'name': await storage.read('user_name', ''),
      'email': await storage.read('user_email', ''),
      'settings': await storage.read('user_settings', <String, dynamic>{}),
      'favorites': favorites,
    };
  }
}

// Usage
final dataManager = AppDataManager();

await dataManager.saveUserProfile(
  name: 'Ali Ahmadi',
  email: 'ali@example.com',
  settings: {
    'theme': 'dark',
    'language': 'fa',
    'notifications': true,
  },
  favorites: ['item1', 'item2', 'item3'],
);

final profile = await dataManager.loadUserProfile();
if (profile != null) {
  print('Name: ${profile['name']}');
  print('Email: ${profile['email']}');
  print('Favorites: ${profile['favorites']}');
}
```

---

## 15. 🎯 Complete App Example

### برنامه کامل با تمام مجوزها

```dart
import 'package:flutter/material.dart';
import 'package:permission_master_ios/permission_master_ios.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Permission Master Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const PermissionDemoPage(),
    );
  }
}

class PermissionDemoPage extends StatefulWidget {
  const PermissionDemoPage({super.key});

  @override
  State<PermissionDemoPage> createState() => _PermissionDemoPageState();
}

class _PermissionDemoPageState extends State<PermissionDemoPage> {
  final _plugin = PermissionMasterIos();
  final Map<String, PermissionStatus> _statuses = {};
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    _initPlatform();
  }

  Future<void> _initPlatform() async {
    try {
      final version = await _plugin.getPlatformVersion() ?? 'Unknown';
      setState(() => _platformVersion = version);
    } catch (e) {
      setState(() => _platformVersion = 'Failed to get version');
    }
  }

  Future<void> _requestPermission(
    String name,
    IconData icon,
    Future<PermissionStatus> Function() request,
  ) async {
    try {
      final status = await request();
      setState(() => _statuses[name] = status);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$name: ${status.name}'),
            backgroundColor: _getStatusColor(status),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Color _getStatusColor(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return Colors.green;
      case PermissionStatus.denied:
        return Colors.red;
      case PermissionStatus.restricted:
        return Colors.orange;
      case PermissionStatus.limited:
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return Icons.check_circle;
      case PermissionStatus.denied:
        return Icons.cancel;
      case PermissionStatus.restricted:
        return Icons.block;
      case PermissionStatus.limited:
        return Icons.warning;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission Master iOS'),
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Platform Info Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Platform Info',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Running on: $_platformVersion'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Request Permissions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          
          // All 13 Permissions
          _buildPermissionTile(
            'Camera',
            Icons.camera_alt,
            () => _requestPermission('Camera', Icons.camera_alt, _plugin.requestCameraPermission),
          ),
          _buildPermissionTile(
            'Photos',
            Icons.photo_library,
            () => _requestPermission('Photos', Icons.photo_library, _plugin.requestPhotosPermission),
          ),
          _buildPermissionTile(
            'Microphone',
            Icons.mic,
            () => _requestPermission('Microphone', Icons.mic, _plugin.requestMicrophonePermission),
          ),
          _buildPermissionTile(
            'Location',
            Icons.location_on,
            () => _requestPermission('Location', Icons.location_on, _plugin.requestLocationPermission),
          ),
          _buildPermissionTile(
            'Contacts',
            Icons.contacts,
            () => _requestPermission('Contacts', Icons.contacts, _plugin.requestContactsPermission),
          ),
          _buildPermissionTile(
            'Calendar',
            Icons.calendar_today,
            () => _requestPermission('Calendar', Icons.calendar_today, _plugin.requestCalendarPermission),
          ),
          _buildPermissionTile(
            'Reminders',
            Icons.alarm,
            () => _requestPermission('Reminders', Icons.alarm, _plugin.requestRemindersPermission),
          ),
          _buildPermissionTile(
            'Notifications',
            Icons.notifications,
            () => _requestPermission('Notifications', Icons.notifications, _plugin.requestNotificationPermission),
          ),
          _buildPermissionTile(
            'Bluetooth',
            Icons.bluetooth,
            () => _requestPermission('Bluetooth', Icons.bluetooth, _plugin.requestBluetoothPermission),
          ),
          _buildPermissionTile(
            'Motion & Fitness',
            Icons.directions_run,
            () => _requestPermission('Motion', Icons.directions_run, _plugin.requestMotionPermission),
          ),
          _buildPermissionTile(
            'Speech Recognition',
            Icons.record_voice_over,
            () => _requestPermission('Speech', Icons.record_voice_over, _plugin.requestSpeechPermission),
          ),
          _buildPermissionTile(
            'Media Library',
            Icons.library_music,
            () => _requestPermission('Music', Icons.library_music, _plugin.requestMusicPermission),
          ),
          _buildPermissionTile(
            'Health',
            Icons.favorite,
            () => _requestPermission('Health', Icons.favorite, _plugin.requestHealthPermission),
          ),
          
          const SizedBox(height: 24),
          
          // Storage Test Button
          ElevatedButton.icon(
            onPressed: _testStorage,
            icon: const Icon(Icons.storage),
            label: const Text('Test Storage'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionTile(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    final status = _statuses[title];
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title),
        trailing: status != null
            ? Icon(
                _getStatusIcon(status),
                color: _getStatusColor(status),
              )
            : const Icon(Icons.arrow_forward_ios, size: 16),
        subtitle: status != null ? Text(status.name) : null,
        onTap: onTap,
      ),
    );
  }

  Future<void> _testStorage() async {
    try {
      final storage = _plugin.storage;
      
      // Write test data
      await storage.write('test_string', 'Hello iOS!');
      await storage.write('test_number', 42);
      await storage.write('test_bool', true);
      await storage.write('test_map', {
        'name': 'Flutter',
        'version': '3.0',
        'platform': 'iOS'
      });
      
      // Read test data
      final stringValue = await storage.read('test_string', '');
      final numberValue = await storage.read('test_number', 0);
      final boolValue = await storage.read('test_bool', false);
      final mapValue = await storage.read('test_map', <String, dynamic>{});
      
      final exists = await storage.contains('test_string');
      
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Storage Test Results'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('String: $stringValue'),
                  Text('Number: $numberValue'),
                  Text('Boolean: $boolValue'),
                  Text('Map: $mapValue'),
                  Text('Key exists: $exists'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Storage test failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
```

---

## نکات مهم برای استفاده

### 1. بررسی وضعیت قبل از درخواست

```dart
// Check first
final status = await plugin.checkPermissionStatus(PermissionType.camera);

if (status == PermissionStatus.notDetermined) {
  // Request permission
  await plugin.requestCameraPermission();
} else if (status == PermissionStatus.granted) {
  // Use feature directly
}
```

### 2. مدیریت خطاها

```dart
try {
  final status = await plugin.requestCameraPermission();
  // Handle status
} catch (e) {
  print('Error requesting permission: $e');
}
```

### 3. Cache کردن وضعیت

```dart
// Save to storage after requesting
final status = await plugin.requestCameraPermission();
await plugin.storage.write('camera_status', status.name);

// Check cache later
final cachedStatus = await plugin.storage.read('camera_status', '');
```

### 4. UI/UX بهتر

```dart
// Show explanation before requesting
await showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Camera Access'),
    content: Text('We need camera access to take photos'),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          plugin.requestCameraPermission();
        },
        child: Text('Allow'),
      ),
    ],
  ),
);
```

### 5. هدایت به Settings برای مجوزهای رد شده

```dart
Future<void> handleDeniedPermission() async {
  final plugin = PermissionMasterIos();
  final status = await plugin.requestCameraPermission();
  
  if (status == PermissionStatus.denied) {
    final shouldOpen = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Denied'),
        content: const Text(
          'Camera permission is required. Would you like to open Settings?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
    
    if (shouldOpen == true) {
      await plugin.openAppSettings();
    }
  }
}
```

---

## خلاصه

این فایل شامل مثال‌های کامل برای:
- ✅ تمام 13 مجوز iOS
- ✅ مدیریت Storage
- ✅ برنامه کامل با UI
- ✅ بهترین روش‌ها (Best Practices)

برای اطلاعات بیشتر، [README.md](README.md) را مطالعه کنید.
