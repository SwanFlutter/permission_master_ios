Here is the English version of your **Permission Master iOS** Flutter plugin documentation:

---

# Permission Master iOS

A Flutter plugin for managing iOS permissions with data storage capabilities.

## Features

✅ Full iOS permission management
✅ Support for 13 different permission types
✅ Data storage using UserDefaults
✅ Compatible with App Store standards
✅ Supports iOS 12.0 and above
✅ Smart permission request count management

## Supported Permissions

| Permission      | Description                     |
|-----------------|---------------------------------|
| 📷 Camera        | Access to the camera            |
| 🖼️ Photos        | Access to the photo library     |
| 🎤 Microphone    | Access to the microphone        |
| 📍 Location      | Access to location services     |
| 👥 Contacts      | Access to contacts              |
| 📅 Calendar      | Access to calendar events       |
| ⏰ Reminders     | Access to reminders             |
| 🔔 Notifications | Access to notifications         |
| 📶 Bluetooth     | Access to Bluetooth             |
| 🏃 Motion        | Access to motion & fitness      |
| 🗣️ Speech        | Access to speech recognition    |
| 🎵 Music         | Access to the media library     |
| ❤️ Health        | Access to health data           |

---

## Installation

### 1. Add to `pubspec.yaml`

```yaml
dependencies:
  permission_master_ios: ^0.0.1
```

### 2. Install the package

```bash
flutter pub get
```

### 3. iOS Setup

#### a) Add permission descriptions to `Info.plist`

Open `ios/Runner/Info.plist` and add the required permission descriptions:

```xml
<dict>
    <!-- Camera -->
    <key>NSCameraUsageDescription</key>
    <string>This app needs camera access to take photos</string>

    <!-- Photo Library -->
    <key>NSPhotoLibraryUsageDescription</key>
    <string>This app needs photo library access to select images</string>
    <key>NSPhotoLibraryAddUsageDescription</key>
    <string>This app needs photo library access to save images</string>

    <!-- Microphone -->
    <key>NSMicrophoneUsageDescription</key>
    <string>This app needs microphone access to record audio</string>

    <!-- Location -->
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>This app needs location access to display your position</string>
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
    <string>This app needs location access to track your position</string>

    <!-- Contacts -->
    <key>NSContactsUsageDescription</key>
    <string>This app needs contacts access to display your contacts</string>

    <!-- Calendar -->
    <key>NSCalendarsUsageDescription</key>
    <string>This app needs calendar access to manage events</string>

    <!-- Reminders -->
    <key>NSRemindersUsageDescription</key>
    <string>This app needs reminders access to manage your reminders</string>

    <!-- Bluetooth -->
    <key>NSBluetoothAlwaysUsageDescription</key>
    <string>This app needs Bluetooth access to connect to devices</string>
    <key>NSBluetoothPeripheralUsageDescription</key>
    <string>This app needs Bluetooth access to connect to devices</string>

    <!-- Motion -->
    <key>NSMotionUsageDescription</key>
    <string>This app needs motion access to track physical activity</string>

    <!-- Speech Recognition -->
    <key>NSSpeechRecognitionUsageDescription</key>
    <string>This app needs speech recognition access for voice commands</string>

    <!-- Media Library -->
    <key>NSAppleMusicUsageDescription</key>
    <string>This app needs media library access to play music</string>

    <!-- Health -->
    <key>NSHealthShareUsageDescription</key>
    <string>This app needs health data access to read health information</string>
    <key>NSHealthUpdateUsageDescription</key>
    <string>This app needs health data access to update health information</string>
</dict>
```

#### b) Create `Podfile`

If `ios/Podfile` does not exist, create it:

```ruby
# ios/Podfile
platform :ios, '12.0'

# CocoaPods analytics sends network stats synchronously affecting flutter build latency.
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

project 'Runner', {
  'Debug' => :debug,
  'Profile' => :release,
  'Release' => :release,
}

def flutter_root
  generated_xcode_build_settings_path = File.expand_path(File.join('..', 'Flutter', 'Generated.xcconfig'), __FILE__)
  unless File.exist?(generated_xcode_build_settings_path)
    raise "#{generated_xcode_build_settings_path} must exist. If you're running pod install manually, make sure flutter pub get is executed first"
  end

  File.foreach(generated_xcode_build_settings_path) do |line|
    matches = line.match(/FLUTTER_ROOT\=(.*)/)
    return matches[1].strip if matches
  end
  raise "FLUTTER_ROOT not found in #{generated_xcode_build_settings_path}. Try deleting Generated.xcconfig, then run flutter pub get"
end

require File.expand_path(File.join('packages', 'flutter_tools', 'bin', 'podhelper'), flutter_root)

flutter_ios_podfile_setup

target 'Runner' do
  use_frameworks!
  use_modular_headers!

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)

    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
```

Or simply run:

```bash
flutter create --platforms=ios .
```

### 4. Run Pod Install

```bash
cd ios
pod install
cd ..
```

---

## Usage

### Practical Examples

#### 📷 Camera Permission

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

Future<void> requestCameraAccess() async {
  final permissionMaster = PermissionMasterIos();

  final status = await permissionMaster.requestCameraPermission();

  if (status == PermissionStatus.granted) {
    // Camera access granted - can use camera
    print('Camera permission granted - can capture photos/videos');
  } else if (status == PermissionStatus.denied) {
    print('Camera permission denied');
  } else if (status == PermissionStatus.restricted) {
    print('Camera access restricted (parental controls)');
  }
}
```

#### 🖼️ Photos Permission

```dart
Future<void> requestPhotosAccess() async {
  final permissionMaster = PermissionMasterIos();

  final status = await permissionMaster.requestPhotosPermission();

  if (status == PermissionStatus.granted) {
    // Full photo library access
    print('Photos permission granted - full access');
  } else if (status == PermissionStatus.limited) {
    // Limited photo library access (iOS 14+)
    print('Photos permission limited - selected photos only');
  } else if (status == PermissionStatus.denied) {
    print('Photos permission denied');
  }
}
```

#### 🎤 Microphone Permission

```dart
Future<void> requestMicrophoneAccess() async {
  final permissionMaster = PermissionMasterIos();

  final status = await permissionMaster.requestMicrophonePermission();

  if (status == PermissionStatus.granted) {
    // Microphone access granted - can record audio
    print('Microphone permission granted - can record audio');
  } else if (status == PermissionStatus.denied) {
    print('Microphone permission denied');
  }
}
```

#### 📍 Location Permission

```dart
Future<void> requestLocationAccess() async {
  final permissionMaster = PermissionMasterIos();

  final status = await permissionMaster.requestLocationPermission();

  if (status == PermissionStatus.granted) {
    // Location access granted - can access user location
    print('Location permission granted - can access GPS');
  } else if (status == PermissionStatus.denied) {
    print('Location permission denied');
  }
}
```

#### 🔔 Notification Permission

```dart
Future<void> requestNotificationAccess() async {
  final permissionMaster = PermissionMasterIos();

  final status = await permissionMaster.requestNotificationPermission();

  if (status == PermissionStatus.granted) {
    // Can send notifications
    print('Notification permission granted - can send push notifications');
  } else if (status == PermissionStatus.denied) {
    print('Notification permission denied');
  }
}
```

#### 👥 Contacts Permission

```dart
Future<void> requestContactsAccess() async {
  final permissionMaster = PermissionMasterIos();

  final status = await permissionMaster.requestContactsPermission();

  if (status == PermissionStatus.granted) {
    // Can access contacts
    print('Contacts permission granted - can read/write contacts');
  } else if (status == PermissionStatus.denied) {
    print('Contacts permission denied');
  }
}
```

#### 📅 Calendar Permission

```dart
Future<void> requestCalendarAccess() async {
  final permissionMaster = PermissionMasterIos();

  final status = await permissionMaster.requestCalendarPermission();

  if (status == PermissionStatus.granted) {
    // Can access calendar events
    print('Calendar permission granted - can manage events');
  } else if (status == PermissionStatus.denied) {
    print('Calendar permission denied');
  }
}
```

#### 💾 Storage (UserDefaults)

```dart
Future<void> useStorage() async {
  final permissionMaster = PermissionMasterIos();
  final storage = permissionMaster.storage;

  // Write data
  await storage.write('username', 'Ali');
  await storage.write('age', 25);
  await storage.write('settings', {'theme': 'dark', 'language': 'fa'});

  // Read data
  final username = await storage.read('username', '');
  final age = await storage.read('age', 0);
  final settings = await storage.read('settings', <String, dynamic>{});

  print('Username: $username');
  print('Age: $age');
  print('Settings: $settings');

  // Check if key exists
  final exists = await storage.contains('username');
  print('Username exists: $exists');

  // Remove key
  await storage.remove('username');

  // Clear all data
  await storage.clear();
}
```

#### 🔍 Check Permission Status (Without Request)

```dart
Future<void> checkPermissionStatus() async {
  final permissionMaster = PermissionMasterIos();

  // Check camera permission without requesting
  final cameraStatus = await permissionMaster.checkPermissionStatus(
    PermissionType.camera,
  );

  if (cameraStatus == PermissionStatus.granted) {
    print('Camera already granted');
  } else if (cameraStatus == PermissionStatus.notDetermined) {
    print('Camera not requested yet');
  }
}
```

#### ⚙️ Open App Settings

```dart
Future<void> openSettings() async {
  final permissionMaster = PermissionMasterIos();

  // Open iOS Settings app for this app
  final opened = await permissionMaster.openAppSettings();

  if (opened) {
    print('Settings opened successfully');
  } else {
    print('Failed to open settings');
  }
}
```

#### 🎯 Complete Permission Flow

```dart
Future<void> requestCameraWithSettings() async {
  final plugin = PermissionMasterIos();

  // First, check current status
  final currentStatus = await plugin.checkPermissionStatus(PermissionType.camera);

  if (currentStatus == PermissionStatus.granted) {
    // Already granted, use camera
    _openCamera();
    return;
  }

  // Request permission
  final status = await plugin.requestCameraPermission();

  if (status == PermissionStatus.granted) {
    // Permission granted, use camera
    _openCamera();
  } else if (status == PermissionStatus.denied) {
    // Show dialog to open settings
    final shouldOpen = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Camera Permission Required'),
        content: const Text(
          'Camera access is required to take photos. '
          'Please enable it in Settings.',
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

### Full UI Example

```dart
import 'package:flutter/material.dart';
import 'package:permission_master_ios/permission_master_ios.dart';

class PermissionExample extends StatefulWidget {
  const PermissionExample({super.key});

  @override
  State<PermissionExample> createState() => _PermissionExampleState();
}

class _PermissionExampleState extends State<PermissionExample> {
  final _plugin = PermissionMasterIos();
  String _status = 'Not requested';

  Future<void> _requestCameraPermission() async {
    final status = await _plugin.requestCameraPermission();
    setState(() {
      _status = 'Camera: ${status.name}';
    });

    if (status == PermissionStatus.granted) {
      // Open camera
      _openCamera();
    } else if (status == PermissionStatus.denied) {
      _showPermissionDeniedDialog();
    }
  }

  void _openCamera() {
    // Your camera logic here
    print('Opening camera...');
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Required'),
        content: const Text(
          'Camera permission is required to take photos. '
          'Please enable it in Settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Open app settings (use app_settings package)
            },
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permission Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _requestCameraPermission,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Request Camera Permission'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

### Requesting Different Permissions

#### All available permissions:

```dart
final plugin = PermissionMasterIos();

// 📷 Camera
final cameraStatus = await plugin.requestCameraPermission();

// 🖼️ Photos
final photosStatus = await plugin.requestPhotosPermission();

// 🎤 Microphone
final micStatus = await plugin.requestMicrophonePermission();

// 📍 Location
final locationStatus = await plugin.requestLocationPermission();

// 👥 Contacts
final contactsStatus = await plugin.requestContactsPermission();

// 📅 Calendar
final calendarStatus = await plugin.requestCalendarPermission();

// ⏰ Reminders
final remindersStatus = await plugin.requestRemindersPermission();

// 🔔 Notifications
final notificationStatus = await plugin.requestNotificationPermission();

// 📶 Bluetooth
final bluetoothStatus = await plugin.requestBluetoothPermission();

// 🏃 Motion & Fitness
final motionStatus = await plugin.requestMotionPermission();

// 🗣️ Speech Recognition
final speechStatus = await plugin.requestSpeechPermission();

// 🎵 Media Library
final musicStatus = await plugin.requestMusicPermission();

// ❤️ Health Data
final healthStatus = await plugin.requestHealthPermission();
```

---

### Check Permission Status Without Request

```dart
final status = await plugin.checkPermissionStatus(PermissionType.camera);

if (status == PermissionStatus.granted) {
  // Permission granted
} else if (status == PermissionStatus.denied) {
  // Permission denied
}
```

---

### Using Storage

#### Writing and reading data:

```dart
final storage = plugin.storage;

// ✍️ Write different types of data
await storage.write('username', 'Ali');
await storage.write('age', 25);
await storage.write('isLoggedIn', true);
await storage.write('score', 95.5);
await storage.write('settings', {
  'theme': 'dark',
  'language': 'fa',
  'notifications': true
});

// 📖 Read data with default values
final username = await storage.read('username', 'Guest');
final age = await storage.read('age', 0);
final isLoggedIn = await storage.read('isLoggedIn', false);
final score = await storage.read('score', 0.0);
final settings = await storage.read('settings', <String, dynamic>{});

print('Username: $username'); // Ali
print('Age: $age'); // 25
print('Logged in: $isLoggedIn'); // true
print('Score: $score'); // 95.5
print('Settings: $settings'); // {theme: dark, language: fa, notifications: true}

// ✅ Check if key exists
final hasUsername = await storage.contains('username');
if (hasUsername) {
  print('Username is stored');
}

// 🗑️ Remove specific key
await storage.remove('username');

// 🧹 Clear all stored data
await storage.clear();
```

#### Practical example - saving user preferences:

```dart
class UserPreferences {
  final storage = PermissionMasterIos().storage;

  // Save user preferences
  Future<void> savePreferences({
    required String theme,
    required String language,
    required bool notifications,
  }) async {
    await storage.write('user_theme', theme);
    await storage.write('user_language', language);
    await storage.write('user_notifications', notifications);
  }

  // Load user preferences
  Future<Map<String, dynamic>> loadPreferences() async {
    final theme = await storage.read('user_theme', 'light');
    final language = await storage.read('user_language', 'en');
    final notifications = await storage.read('user_notifications', true);

    return {
      'theme': theme,
      'language': language,
      'notifications': notifications,
    };
  }

  // Check if user has saved preferences
  Future<bool> hasPreferences() async {
    return await storage.contains('user_theme');
  }

  // Reset to defaults
  Future<void> resetPreferences() async {
    await storage.remove('user_theme');
    await storage.remove('user_language');
    await storage.remove('user_notifications');
  }
}

// Usage
final prefs = UserPreferences();

// Save
await prefs.savePreferences(
  theme: 'dark',
  language: 'fa',
  notifications: true,
);

// Load
final settings = await prefs.loadPreferences();
print(settings); // {theme: dark, language: fa, notifications: true}
```

---

## Permission Statuses

```dart
enum PermissionStatus {
  granted,        // Permission granted
  denied,         // Permission denied
  restricted,     // Restricted (parental controls, etc.)
  limited,        // Limited (partial access, e.g., selected photos in iOS 14+)
  notDetermined,  // Not requested yet
  openSettings,   // Needs to open settings
  unsupported,    // Not supported
  error           // Error occurred
}
```

---

## Important App Store Tips

### 1. Clear and Transparent Descriptions

Always provide a clear reason for each permission in `Info.plist`.

### 2. Request at the Right Time

Only request permissions when the user intends to use the feature.

```dart
// ❌ Bad: Request at app startup
@override
void initState() {
  super.initState();
  _plugin.requestCameraPermission();
}

// ✅ Good: Request when the camera button is clicked
void _openCamera() async {
  final status = await _plugin.requestCameraPermission();
  if (status == PermissionStatus.granted) {
    // Open camera
  }
}
```

### 3. Handle Permission Denial

```dart
Future<void> _handlePermission() async {
  final status = await _plugin.requestCameraPermission();

  switch (status) {
    case PermissionStatus.granted:
      // Use the feature
      break;
    case PermissionStatus.denied:
      // Show a helpful message
      _showPermissionDialog();
      break;
    case PermissionStatus.restricted:
      // Inform about restrictions
      break;
    default:
      break;
  }
}

void _showPermissionDialog() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Permission Required'),
      content: const Text('Camera access is required to take photos. Please enable it in Settings.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () {
            // Redirect to settings
            // Use the app_settings package
          },
          child: const Text('Settings'),
        ),
      ],
    ),
  );
}
```

### 4. Privacy Manifest

The `ios/Resources/PrivacyInfo.xcprivacy` file is available to comply with Apple's privacy standards.

---

## Full Example

For a complete example, check the `example` folder:

```bash
cd example
flutter run
```

---

## Common Issues

### "Permission denied" error

Ensure that permission descriptions are added to `Info.plist`.

### "Module not found" error

```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
```

### Permission not requested

- Verify that permission descriptions in `Info.plist` are correct
- Fully close and reopen the app
- In the simulator, check Settings > Privacy

---

## Requirements

- Flutter: >=3.3.0
- iOS: >=12.0
- Dart: ^3.10.8

---



# Permission Master iOS

یک پلاگین Flutter برای مدیریت مجوزهای iOS با قابلیت ذخیره‌سازی داده‌ها.

## ویژگی‌ها

✅ مدیریت کامل مجوزهای iOS  
✅ پشتیبانی از 13 نوع مجوز مختلف  
✅ ذخیره‌سازی داده با استفاده از UserDefaults  
✅ سازگار با استانداردهای App Store  
✅ پشتیبانی از iOS 12.0 به بالا  
✅ مدیریت هوشمند تعداد درخواست مجوزها  

## مجوزهای پشتیبانی شده

| مجوز | توضیحات |
|------|---------|
| 📷 Camera | دسترسی به دوربین |
| 🖼️ Photos | دسترسی به کتابخانه تصاویر |
| 🎤 Microphone | دسترسی به میکروفون |
| 📍 Location | دسترسی به موقعیت مکانی |
| 👥 Contacts | دسترسی به مخاطبین |
| 📅 Calendar | دسترسی به تقویم |
| ⏰ Reminders | دسترسی به یادآورها |
| 🔔 Notifications | دسترسی به اعلان‌ها |
| 📶 Bluetooth | دسترسی به بلوتوث |
| 🏃 Motion | دسترسی به حرکت و فیتنس |
| 🗣️ Speech | دسترسی به تشخیص گفتار |
| 🎵 Music | دسترسی به کتابخانه موسیقی |
| ❤️ Health | دسترسی به داده‌های سلامت |

## نصب

### 1. افزودن به pubspec.yaml

```yaml
dependencies:
  permission_master_ios: ^0.0.1
```

### 2. نصب پکیج

```bash
flutter pub get
```

### 3. تنظیمات iOS

#### الف) افزودن توضیحات مجوزها به Info.plist

فایل `ios/Runner/Info.plist` را باز کنید و توضیحات مجوزهای مورد نیاز خود را اضافه کنید:

```xml
<dict>
    <!-- Camera -->
    <key>NSCameraUsageDescription</key>
    <string>این برنامه برای گرفتن عکس به دوربین نیاز دارد</string>
    
    <!-- Photo Library -->
    <key>NSPhotoLibraryUsageDescription</key>
    <string>این برنامه برای انتخاب تصاویر به کتابخانه عکس نیاز دارد</string>
    <key>NSPhotoLibraryAddUsageDescription</key>
    <string>این برنامه برای ذخیره تصاویر به کتابخانه عکس نیاز دارد</string>
    
    <!-- Microphone -->
    <key>NSMicrophoneUsageDescription</key>
    <string>این برنامه برای ضبط صدا به میکروفون نیاز دارد</string>
    
    <!-- Location -->
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>این برنامه برای نمایش موقعیت شما به دسترسی مکانی نیاز دارد</string>
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
    <string>این برنامه برای ردیابی موقعیت به دسترسی مکانی نیاز دارد</string>
    
    <!-- Contacts -->
    <key>NSContactsUsageDescription</key>
    <string>این برنامه برای نمایش مخاطبین به دسترسی مخاطبین نیاز دارد</string>
    
    <!-- Calendar -->
    <key>NSCalendarsUsageDescription</key>
    <string>این برنامه برای مدیریت رویدادها به تقویم نیاز دارد</string>
    
    <!-- Reminders -->
    <key>NSRemindersUsageDescription</key>
    <string>این برنامه برای مدیریت یادآورها نیاز دارد</string>
    
    <!-- Bluetooth -->
    <key>NSBluetoothAlwaysUsageDescription</key>
    <string>این برنامه برای اتصال به دستگاه‌های بلوتوث نیاز دارد</string>
    <key>NSBluetoothPeripheralUsageDescription</key>
    <string>این برنامه برای اتصال به دستگاه‌های بلوتوث نیاز دارد</string>
    
    <!-- Motion -->
    <key>NSMotionUsageDescription</key>
    <string>این برنامه برای ردیابی فعالیت فیزیکی نیاز دارد</string>
    
    <!-- Speech Recognition -->
    <key>NSSpeechRecognitionUsageDescription</key>
    <string>این برنامه برای تشخیص گفتار نیاز دارد</string>
    
    <!-- Media Library -->
    <key>NSAppleMusicUsageDescription</key>
    <string>این برنامه برای دسترسی به کتابخانه موسیقی نیاز دارد</string>
    
    <!-- Health -->
    <key>NSHealthShareUsageDescription</key>
    <string>این برنامه برای خواندن داده‌های سلامت نیاز دارد</string>
    <key>NSHealthUpdateUsageDescription</key>
    <string>این برنامه برای به‌روزرسانی داده‌های سلامت نیاز دارد</string>
</dict>
```

#### ب) ایجاد Podfile

اگر فایل `ios/Podfile` وجود ندارد، آن را ایجاد کنید:

```ruby
# ios/Podfile
platform :ios, '12.0'

# CocoaPods analytics sends network stats synchronously affecting flutter build latency.
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

project 'Runner', {
  'Debug' => :debug,
  'Profile' => :release,
  'Release' => :release,
}

def flutter_root
  generated_xcode_build_settings_path = File.expand_path(File.join('..', 'Flutter', 'Generated.xcconfig'), __FILE__)
  unless File.exist?(generated_xcode_build_settings_path)
    raise "#{generated_xcode_build_settings_path} must exist. If you're running pod install manually, make sure flutter pub get is executed first"
  end

  File.foreach(generated_xcode_build_settings_path) do |line|
    matches = line.match(/FLUTTER_ROOT\=(.*)/)
    return matches[1].strip if matches
  end
  raise "FLUTTER_ROOT not found in #{generated_xcode_build_settings_path}. Try deleting Generated.xcconfig, then run flutter pub get"
end

require File.expand_path(File.join('packages', 'flutter_tools', 'bin', 'podhelper'), flutter_root)

flutter_ios_podfile_setup

target 'Runner' do
  use_frameworks!
  use_modular_headers!

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
```

یا به سادگی:

```bash
flutter create --platforms=ios .
```

### 4. اجرای Pod Install

```bash
cd ios
pod install
cd ..
```

## استفاده

### مثال‌های کاربردی

#### 📷 Camera Permission

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

Future<void> requestCameraAccess() async {
  final permissionMaster = PermissionMasterIos();
  
  final status = await permissionMaster.requestCameraPermission();
  
  if (status == PermissionStatus.granted) {
    // Camera access granted - can use camera
    print('Camera permission granted - can capture photos/videos');
  } else if (status == PermissionStatus.denied) {
    print('Camera permission denied');
  } else if (status == PermissionStatus.restricted) {
    print('Camera access restricted (parental controls)');
  }
}
```

#### 🖼️ Photos Permission

```dart
Future<void> requestPhotosAccess() async {
  final permissionMaster = PermissionMasterIos();
  
  final status = await permissionMaster.requestPhotosPermission();
  
  if (status == PermissionStatus.granted) {
    // Full photo library access
    print('Photos permission granted - full access');
  } else if (status == PermissionStatus.limited) {
    // Limited photo library access (iOS 14+)
    print('Photos permission limited - selected photos only');
  } else if (status == PermissionStatus.denied) {
    print('Photos permission denied');
  }
}
```

#### 🎤 Microphone Permission

```dart
Future<void> requestMicrophoneAccess() async {
  final permissionMaster = PermissionMasterIos();
  
  final status = await permissionMaster.requestMicrophonePermission();
  
  if (status == PermissionStatus.granted) {
    // Microphone access granted - can record audio
    print('Microphone permission granted - can record audio');
  } else if (status == PermissionStatus.denied) {
    print('Microphone permission denied');
  }
}
```

#### 📍 Location Permission

```dart
Future<void> requestLocationAccess() async {
  final permissionMaster = PermissionMasterIos();
  
  final status = await permissionMaster.requestLocationPermission();
  
  if (status == PermissionStatus.granted) {
    // Location access granted - can access user location
    print('Location permission granted - can access GPS');
  } else if (status == PermissionStatus.denied) {
    print('Location permission denied');
  }
}
```

#### 🔔 Notification Permission

```dart
Future<void> requestNotificationAccess() async {
  final permissionMaster = PermissionMasterIos();
  
  final status = await permissionMaster.requestNotificationPermission();
  
  if (status == PermissionStatus.granted) {
    // Can send notifications
    print('Notification permission granted - can send push notifications');
  } else if (status == PermissionStatus.denied) {
    print('Notification permission denied');
  }
}
```

#### 👥 Contacts Permission

```dart
Future<void> requestContactsAccess() async {
  final permissionMaster = PermissionMasterIos();
  
  final status = await permissionMaster.requestContactsPermission();
  
  if (status == PermissionStatus.granted) {
    // Can access contacts
    print('Contacts permission granted - can read/write contacts');
  } else if (status == PermissionStatus.denied) {
    print('Contacts permission denied');
  }
}
```

#### 📅 Calendar Permission

```dart
Future<void> requestCalendarAccess() async {
  final permissionMaster = PermissionMasterIos();
  
  final status = await permissionMaster.requestCalendarPermission();
  
  if (status == PermissionStatus.granted) {
    // Can access calendar events
    print('Calendar permission granted - can manage events');
  } else if (status == PermissionStatus.denied) {
    print('Calendar permission denied');
  }
}
```

#### 💾 Storage (UserDefaults)

```dart
Future<void> useStorage() async {
  final permissionMaster = PermissionMasterIos();
  final storage = permissionMaster.storage;
  
  // Write data
  await storage.write('username', 'Ali');
  await storage.write('age', 25);
  await storage.write('settings', {'theme': 'dark', 'language': 'fa'});
  
  // Read data
  final username = await storage.read('username', '');
  final age = await storage.read('age', 0);
  final settings = await storage.read('settings', <String, dynamic>{});
  
  print('Username: $username');
  print('Age: $age');
  print('Settings: $settings');
  
  // Check if key exists
  final exists = await storage.contains('username');
  print('Username exists: $exists');
  
  // Remove key
  await storage.remove('username');
  
  // Clear all data
  await storage.clear();
}
```

#### 🔍 Check Permission Status (بدون درخواست)

```dart
Future<void> checkPermissionStatus() async {
  final permissionMaster = PermissionMasterIos();
  
  // Check camera permission without requesting
  final cameraStatus = await permissionMaster.checkPermissionStatus(
    PermissionType.camera,
  );
  
  if (cameraStatus == PermissionStatus.granted) {
    print('Camera already granted');
  } else if (cameraStatus == PermissionStatus.notDetermined) {
    print('Camera not requested yet');
  }
}
```

#### ⚙️ Open App Settings

```dart
Future<void> openSettings() async {
  final permissionMaster = PermissionMasterIos();
  
  // Open iOS Settings app for this app
  final opened = await permissionMaster.openAppSettings();
  
  if (opened) {
    print('Settings opened successfully');
  } else {
    print('Failed to open settings');
  }
}
```

#### 🎯 Complete Permission Flow

```dart
Future<void> requestCameraWithSettings() async {
  final plugin = PermissionMasterIos();
  
  // First, check current status
  final currentStatus = await plugin.checkPermissionStatus(PermissionType.camera);
  
  if (currentStatus == PermissionStatus.granted) {
    // Already granted, use camera
    _openCamera();
    return;
  }
  
  // Request permission
  final status = await plugin.requestCameraPermission();
  
  if (status == PermissionStatus.granted) {
    // Permission granted, use camera
    _openCamera();
  } else if (status == PermissionStatus.denied) {
    // Show dialog to open settings
    final shouldOpen = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Camera Permission Required'),
        content: const Text(
          'Camera access is required to take photos. '
          'Please enable it in Settings.',
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

### مثال کامل با UI

```dart
import 'package:flutter/material.dart';
import 'package:permission_master_ios/permission_master_ios.dart';

class PermissionExample extends StatefulWidget {
  const PermissionExample({super.key});

  @override
  State<PermissionExample> createState() => _PermissionExampleState();
}

class _PermissionExampleState extends State<PermissionExample> {
  final _plugin = PermissionMasterIos();
  String _status = 'Not requested';

  Future<void> _requestCameraPermission() async {
    final status = await _plugin.requestCameraPermission();
    setState(() {
      _status = 'Camera: ${status.name}';
    });
    
    if (status == PermissionStatus.granted) {
      // Open camera
      _openCamera();
    } else if (status == PermissionStatus.denied) {
      _showPermissionDeniedDialog();
    }
  }
  
  void _openCamera() {
    // Your camera logic here
    print('Opening camera...');
  }
  
  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Required'),
        content: const Text(
          'Camera permission is required to take photos. '
          'Please enable it in Settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Open app settings (use app_settings package)
            },
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permission Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _requestCameraPermission,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Request Camera Permission'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### درخواست مجوزهای مختلف

#### تمام مجوزهای موجود:

```dart
final plugin = PermissionMasterIos();

// 📷 Camera
final cameraStatus = await plugin.requestCameraPermission();

// 🖼️ Photos
final photosStatus = await plugin.requestPhotosPermission();

// 🎤 Microphone
final micStatus = await plugin.requestMicrophonePermission();

// 📍 Location
final locationStatus = await plugin.requestLocationPermission();

// 👥 Contacts
final contactsStatus = await plugin.requestContactsPermission();

// 📅 Calendar
final calendarStatus = await plugin.requestCalendarPermission();

// ⏰ Reminders
final remindersStatus = await plugin.requestRemindersPermission();

// 🔔 Notifications
final notificationStatus = await plugin.requestNotificationPermission();

// 📶 Bluetooth
final bluetoothStatus = await plugin.requestBluetoothPermission();

// 🏃 Motion & Fitness
final motionStatus = await plugin.requestMotionPermission();

// 🗣️ Speech Recognition
final speechStatus = await plugin.requestSpeechPermission();

// 🎵 Media Library
final musicStatus = await plugin.requestMusicPermission();

// ❤️ Health Data
final healthStatus = await plugin.requestHealthPermission();
```

### بررسی وضعیت مجوز بدون درخواست

```dart
final status = await plugin.checkPermissionStatus(PermissionType.camera);

if (status == PermissionStatus.granted) {
  // مجوز داده شده
} else if (status == PermissionStatus.denied) {
  // مجوز رد شده
}
```

### استفاده از Storage

#### نوشتن و خواندن داده‌ها:

```dart
final storage = plugin.storage;

// ✍️ Write different types of data
await storage.write('username', 'Ali');
await storage.write('age', 25);
await storage.write('isLoggedIn', true);
await storage.write('score', 95.5);
await storage.write('settings', {
  'theme': 'dark',
  'language': 'fa',
  'notifications': true
});

// 📖 Read data with default values
final username = await storage.read('username', 'Guest');
final age = await storage.read('age', 0);
final isLoggedIn = await storage.read('isLoggedIn', false);
final score = await storage.read('score', 0.0);
final settings = await storage.read('settings', <String, dynamic>{});

print('Username: $username'); // Ali
print('Age: $age'); // 25
print('Logged in: $isLoggedIn'); // true
print('Score: $score'); // 95.5
print('Settings: $settings'); // {theme: dark, language: fa, notifications: true}

// ✅ Check if key exists
final hasUsername = await storage.contains('username');
if (hasUsername) {
  print('Username is stored');
}

// 🗑️ Remove specific key
await storage.remove('username');

// 🧹 Clear all stored data
await storage.clear();
```

#### مثال عملی - ذخیره تنظیمات کاربر:

```dart
class UserPreferences {
  final storage = PermissionMasterIos().storage;
  
  // Save user preferences
  Future<void> savePreferences({
    required String theme,
    required String language,
    required bool notifications,
  }) async {
    await storage.write('user_theme', theme);
    await storage.write('user_language', language);
    await storage.write('user_notifications', notifications);
  }
  
  // Load user preferences
  Future<Map<String, dynamic>> loadPreferences() async {
    final theme = await storage.read('user_theme', 'light');
    final language = await storage.read('user_language', 'en');
    final notifications = await storage.read('user_notifications', true);
    
    return {
      'theme': theme,
      'language': language,
      'notifications': notifications,
    };
  }
  
  // Check if user has saved preferences
  Future<bool> hasPreferences() async {
    return await storage.contains('user_theme');
  }
  
  // Reset to defaults
  Future<void> resetPreferences() async {
    await storage.remove('user_theme');
    await storage.remove('user_language');
    await storage.remove('user_notifications');
  }
}

// Usage
final prefs = UserPreferences();

// Save
await prefs.savePreferences(
  theme: 'dark',
  language: 'fa',
  notifications: true,
);

// Load
final settings = await prefs.loadPreferences();
print(settings); // {theme: dark, language: fa, notifications: true}
```

## وضعیت‌های مجوز

```dart
enum PermissionStatus {
  granted,        // مجوز داده شده
  denied,         // مجوز رد شده
  restricted,     // محدود شده (کنترل والدین و...)
  limited,        // محدود (دسترسی محدود به تصاویر در iOS 14+)
  notDetermined,  // هنوز تعیین نشده
  openSettings,   // نیاز به باز کردن تنظیمات
  unsupported,    // پشتیبانی نمی‌شود
  error          // خطا رخ داده
}
```

## نکات مهم برای App Store

### 1. توضیحات واضح و شفاف

همیشه دلیل واضحی برای درخواست هر مجوز در `Info.plist` ارائه دهید.

### 2. درخواست در زمان مناسب

مجوزها را فقط زمانی درخواست کنید که کاربر قصد استفاده از آن قابلیت را دارد.

```dart
// ❌ بد: درخواست در شروع برنامه
@override
void initState() {
  super.initState();
  _plugin.requestCameraPermission();
}

// ✅ خوب: درخواست هنگام کلیک روی دکمه دوربین
void _openCamera() async {
  final status = await _plugin.requestCameraPermission();
  if (status == PermissionStatus.granted) {
    // باز کردن دوربین
  }
}
```

### 3. مدیریت رد مجوز

```dart
Future<void> _handlePermission() async {
  final status = await _plugin.requestCameraPermission();
  
  switch (status) {
    case PermissionStatus.granted:
      // استفاده از قابلیت
      break;
    case PermissionStatus.denied:
      // نمایش پیام راهنما
      _showPermissionDialog();
      break;
    case PermissionStatus.restricted:
      // اطلاع‌رسانی محدودیت
      break;
    default:
      break;
  }
}

void _showPermissionDialog() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('نیاز به مجوز'),
      content: const Text('برای استفاده از این قابلیت، لطفاً مجوز دوربین را فعال کنید.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('بستن'),
        ),
        TextButton(
          onPressed: () {
            // هدایت به تنظیمات
            // از پکیج app_settings استفاده کنید
          },
          child: const Text('تنظیمات'),
        ),
      ],
    ),
  );
}
```

### 4. Privacy Manifest

فایل `ios/Resources/PrivacyInfo.xcprivacy` برای رعایت استانداردهای حریم خصوصی Apple موجود است.

## مثال کامل

برای مشاهده مثال کامل، پوشه `example` را بررسی کنید:

```bash
cd example
flutter run
```



## مشکلات رایج

### خطای "Permission denied"

مطمئن شوید که توضیحات مجوز در `Info.plist` اضافه شده است.

### خطای "Module not found"

```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
```

### مجوز درخواست نمی‌شود

- بررسی کنید که توضیحات مجوز در `Info.plist` صحیح باشد
- برنامه را کاملاً ببندید و دوباره اجرا کنید
- در شبیه‌ساز، Settings > Privacy را بررسی کنید

## الزامات

- Flutter: >=3.3.0
- iOS: >=12.0
- Dart: ^3.10.8


