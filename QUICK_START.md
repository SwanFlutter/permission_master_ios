
Here’s the English version of your **Permission Master iOS Quick Guide**:

---

# Quick Guide - Permission Master iOS

## Quick Setup (5 Minutes)

### Step 1: Add to Project

```yaml
# pubspec.yaml
dependencies:
  permission_master_ios: ^0.0.1
```

```bash
flutter pub get
```

### Step 2: Configure Info.plist

Open the `ios/Runner/Info.plist` file and add these lines:

```xml
<key>NSCameraUsageDescription</key>
<string>Required to take photos</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>Required to select images</string>

<key>NSMicrophoneUsageDescription</key>
<string>Required to record audio</string>
```

### Step 3: Install Pods

```bash
cd ios
pod install
cd ..
```

### Step 4: Use in Code

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

// Create an instance
final plugin = PermissionMasterIos();

// Request permission
final status = await plugin.requestCameraPermission();

// Check status
if (status == PermissionStatus.granted) {
  // Use the camera
}
```

---

## Full Example

```dart
import 'package:flutter/material.dart';
import 'package:permission_master_ios/permission_master_ios.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final _plugin = PermissionMasterIos();

  Future<void> _openCamera() async {
    final status = await _plugin.requestCameraPermission();

    if (status == PermissionStatus.granted) {
      // Open the camera
      print('Camera opened');
    } else if (status == PermissionStatus.denied) {
      // Show a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera permission denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      body: Center(
        child: ElevatedButton(
          onPressed: _openCamera,
          child: Text('Open Camera'),
        ),
      ),
    );
  }
}
```

---

## Common Permissions

### Camera
```dart
await plugin.requestCameraPermission();
```

### Photos
```dart
await plugin.requestPhotosPermission();
```

### Microphone
```dart
await plugin.requestMicrophonePermission();
```

### Location
```dart
await plugin.requestLocationPermission();
```

### Notifications
```dart
await plugin.requestNotificationPermission();
```

---

## Using Storage

```dart
final storage = plugin.storage;

// Save
await storage.write('key', 'value');

// Read
final value = await storage.read('key', 'default');

// Delete
await storage.remove('key');
```

---

## Important Tips

1. ✅ Always add permission descriptions in Info.plist
2. ✅ Request permissions at the right time
3. ✅ Handle denied status gracefully
4. ❌ Do not request all permissions at app startup

---

## Common Issues

### Permission Not Requested
- Ensure Info.plist is configured correctly
- Fully close and reopen the app

### Build Error
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter run
```

---

## Further Resources

- [Full README](README.md)
- [Technical Documentation](doc.md)
- [Complete Example](example/)

---

## Support

For questions and issues, create an Issue on GitHub.




# راهنمای سریع - Permission Master iOS

## نصب سریع (5 دقیقه)

### گام 1: افزودن به پروژه

```yaml
# pubspec.yaml
dependencies:
  permission_master_ios: ^0.0.1
```

```bash
flutter pub get
```

### گام 2: تنظیم Info.plist

فایل `ios/Runner/Info.plist` را باز کنید و این خطوط را اضافه کنید:

```xml
<key>NSCameraUsageDescription</key>
<string>برای گرفتن عکس نیاز است</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>برای انتخاب تصاویر نیاز است</string>

<key>NSMicrophoneUsageDescription</key>
<string>برای ضبط صدا نیاز است</string>
```

### گام 3: نصب Pods

```bash
cd ios
pod install
cd ..
```

### گام 4: استفاده در کد

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

// ایجاد instance
final plugin = PermissionMasterIos();

// درخواست مجوز
final status = await plugin.requestCameraPermission();

// بررسی وضعیت
if (status == PermissionStatus.granted) {
  // استفاده از دوربین
}
```

## مثال کامل

```dart
import 'package:flutter/material.dart';
import 'package:permission_master_ios/permission_master_ios.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final _plugin = PermissionMasterIos();

  Future<void> _openCamera() async {
    final status = await _plugin.requestCameraPermission();
    
    if (status == PermissionStatus.granted) {
      // باز کردن دوربین
      print('دوربین باز شد');
      // TODO: Implement camera functionality
    } else if (status == PermissionStatus.denied) {
      // نمایش پیام راهنما
      _showPermissionDialog();
    } else if (status == PermissionStatus.restricted) {
      // محدودیت سیستمی (کنترل والدین)
      _showRestrictedDialog();
    }
  }
  
  void _showPermissionDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('مجوز دوربین رد شد. لطفاً از تنظیمات فعال کنید.'),
        action: SnackBarAction(
          label: 'تنظیمات',
          onPressed: null, // Open settings
        ),
      ),
    );
  }
  
  void _showRestrictedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('دسترسی محدود'),
        content: const Text(
          'دسترسی به دوربین توسط تنظیمات دستگاه محدود شده است.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('متوجه شدم'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('دوربین')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _openCamera,
          icon: const Icon(Icons.camera_alt),
          label: const Text('باز کردن دوربین'),
        ),
      ),
    );
  }
}
```

## مجوزهای پرکاربرد

### 📷 Camera
```dart
final status = await plugin.requestCameraPermission();
if (status == PermissionStatus.granted) {
  // Use camera
}
```

### 🖼️ Photos
```dart
final status = await plugin.requestPhotosPermission();
if (status == PermissionStatus.granted) {
  // Access photo library
} else if (status == PermissionStatus.limited) {
  // Limited access (iOS 14+)
}
```

### 🎤 Microphone
```dart
final status = await plugin.requestMicrophonePermission();
if (status == PermissionStatus.granted) {
  // Record audio
}
```

### 📍 Location
```dart
final status = await plugin.requestLocationPermission();
if (status == PermissionStatus.granted) {
  // Access GPS location
}
```

### 🔔 Notifications
```dart
final status = await plugin.requestNotificationPermission();
if (status == PermissionStatus.granted) {
  // Send push notifications
}
```

### 👥 Contacts
```dart
final status = await plugin.requestContactsPermission();
if (status == PermissionStatus.granted) {
  // Access contacts
}
```

### 📅 Calendar
```dart
final status = await plugin.requestCalendarPermission();
if (status == PermissionStatus.granted) {
  // Manage calendar events
}
```

## استفاده از Storage

```dart
final storage = plugin.storage;

// ✍️ Write data
await storage.write('username', 'Ali');
await storage.write('age', 25);
await storage.write('settings', {
  'theme': 'dark',
  'language': 'fa'
});

// 📖 Read data
final username = await storage.read('username', 'Guest');
final age = await storage.read('age', 0);
final settings = await storage.read('settings', <String, dynamic>{});

print('Username: $username'); // Ali
print('Age: $age'); // 25
print('Settings: $settings'); // {theme: dark, language: fa}

// ✅ Check existence
final exists = await storage.contains('username');
print('Has username: $exists'); // true

// 🗑️ Remove key
await storage.remove('username');

// 🧹 Clear all
await storage.clear();
```

### مثال عملی - ذخیره وضعیت مجوزها

```dart
class PermissionTracker {
  final storage = PermissionMasterIos().storage;
  
  Future<void> savePermissionStatus(String permission, bool granted) async {
    await storage.write('permission_$permission', granted);
    await storage.write('permission_${permission}_date', DateTime.now().toIso8601String());
  }
  
  Future<bool> wasPermissionGranted(String permission) async {
    return await storage.read('permission_$permission', false);
  }
  
  Future<String?> getPermissionDate(String permission) async {
    return await storage.read('permission_${permission}_date', null);
  }
}

// Usage
final tracker = PermissionTracker();

// After requesting permission
final status = await plugin.requestCameraPermission();
await tracker.savePermissionStatus('camera', status == PermissionStatus.granted);

// Check later
final wasGranted = await tracker.wasPermissionGranted('camera');
final grantedDate = await tracker.getPermissionDate('camera');
print('Camera was granted: $wasGranted on $grantedDate');
```

## نکات مهم

1. ✅ همیشه توضیحات مجوز را در Info.plist اضافه کنید
2. ✅ مجوز را در زمان مناسب درخواست کنید
3. ✅ وضعیت رد شدن را مدیریت کنید
4. ❌ همه مجوزها را در ابتدای برنامه درخواست نکنید

## مشکلات رایج

### مجوز درخواست نمی‌شود
- بررسی کنید Info.plist را تنظیم کرده‌اید
- برنامه را کاملاً ببندید و دوباره باز کنید

### خطای Build
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter run
```

## منابع بیشتر

- [README کامل](README.md)
- [مستندات فنی](doc%20.md)
- [مثال کامل](example/)

## پشتیبانی

برای سوالات و مشکلات، یک Issue در GitHub ایجاد کنید.
