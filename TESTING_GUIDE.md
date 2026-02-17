# راهنمای تست - Permission Master iOS

این راهنما نحوه تست پلاگین را توضیح می‌دهد.

## انواع تست

### 1. Unit Tests (تست‌های واحد)

تست‌های واحد برای بررسی عملکرد صحیح کد Dart.

**مکان:** `test/permission_master_ios_test.dart`

**اجرا:**
```bash
flutter test
```

**محتوا:**
- ✅ تست تمام 13 مجوز
- ✅ تست وضعیت‌های مختلف (granted, denied, restricted, limited)
- ✅ تست checkPermissionStatus
- ✅ تست openAppSettings
- ✅ تست Storage
- ✅ تست PermissionType enum
- ✅ تست PermissionStatus enum

### 2. Integration Tests (تست‌های یکپارچه)

تست‌های یکپارچه برای بررسی عملکرد واقعی روی دستگاه.

**مکان:** `example/integration_test/plugin_integration_test.dart`

**اجرا:**
```bash
cd example
flutter test integration_test/plugin_integration_test.dart
```

### 3. Manual Testing (تست دستی)

تست دستی با اجرای برنامه نمونه.

**اجرا:**
```bash
cd example
flutter run
```

## تست‌های Unit

### ساختار تست

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:permission_master_ios/permission_master_ios.dart';

void main() {
  group('Camera Permission', () {
    test('returns granted status', () async {
      // Arrange
      final plugin = PermissionMasterIos();
      
      // Act
      final status = await plugin.requestCameraPermission();
      
      // Assert
      expect(status, isA<PermissionStatus>());
    });
  });
}
```

### تست‌های موجود

#### 1. Platform Version
```dart
test('getPlatformVersion returns iOS version', () async {
  final version = await plugin.getPlatformVersion();
  expect(version, contains('iOS'));
});
```

#### 2. Camera Permission
```dart
test('Camera permission returns granted', () async {
  final status = await plugin.requestCameraPermission();
  expect(status, PermissionStatus.granted);
});

test('Camera permission returns denied', () async {
  final status = await plugin.requestCameraPermission();
  expect(status, PermissionStatus.denied);
});
```

#### 3. All 13 Permissions
```dart
test('All permissions work', () async {
  expect(await plugin.requestCameraPermission(), isA<PermissionStatus>());
  expect(await plugin.requestPhotosPermission(), isA<PermissionStatus>());
  expect(await plugin.requestMicrophonePermission(), isA<PermissionStatus>());
  // ... و بقیه
});
```

#### 4. Check Permission Status
```dart
test('Check permission without requesting', () async {
  final status = await plugin.checkPermissionStatus(PermissionType.camera);
  expect(status, isA<PermissionStatus>());
});
```

#### 5. Open App Settings
```dart
test('Open settings returns boolean', () async {
  final result = await plugin.openAppSettings();
  expect(result, isA<bool>());
});
```

## تست دستی

### چک‌لیست تست دستی

#### 1. Camera Permission
- [ ] درخواست مجوز
- [ ] قبول کردن مجوز
- [ ] رد کردن مجوز
- [ ] باز کردن Settings
- [ ] فعال کردن از Settings
- [ ] بررسی مجدد وضعیت

#### 2. Photos Permission
- [ ] درخواست مجوز
- [ ] انتخاب "Select Photos" (Limited)
- [ ] انتخاب "Allow Access to All Photos"
- [ ] رد کردن مجوز

#### 3. Microphone Permission
- [ ] درخواست مجوز
- [ ] قبول کردن
- [ ] رد کردن
- [ ] تست ضبط صدا

#### 4. Location Permission
- [ ] درخواست مجوز
- [ ] "Allow While Using App"
- [ ] "Allow Once"
- [ ] "Don't Allow"

#### 5. Contacts Permission
- [ ] درخواست مجوز
- [ ] قبول کردن
- [ ] رد کردن
- [ ] دسترسی به مخاطبین

#### 6. Calendar Permission
- [ ] درخواست مجوز
- [ ] قبول کردن
- [ ] رد کردن
- [ ] ایجاد رویداد

#### 7. Reminders Permission
- [ ] درخواست مجوز
- [ ] قبول کردن
- [ ] رد کردن
- [ ] ایجاد یادآور

#### 8. Notifications Permission
- [ ] درخواست مجوز
- [ ] قبول کردن
- [ ] رد کردن
- [ ] ارسال اعلان تستی

#### 9. Bluetooth Permission
- [ ] درخواست مجوز
- [ ] قبول کردن
- [ ] رد کردن
- [ ] اسکن دستگاه‌ها

#### 10. Motion Permission
- [ ] درخواست مجوز
- [ ] قبول کردن
- [ ] رد کردن
- [ ] خواندن داده‌های حرکت

#### 11. Speech Recognition Permission
- [ ] درخواست مجوز
- [ ] قبول کردن
- [ ] رد کردن
- [ ] تست تشخیص گفتار

#### 12. Media Library Permission
- [ ] درخواست مجوز
- [ ] قبول کردن
- [ ] رد کردن
- [ ] دسترسی به موسیقی

#### 13. Health Permission
- [ ] درخواست مجوز
- [ ] قبول کردن
- [ ] رد کردن
- [ ] خواندن داده‌های سلامت

### Storage Testing
- [ ] نوشتن String
- [ ] نوشتن Number
- [ ] نوشتن Boolean
- [ ] نوشتن Map
- [ ] خواندن داده‌ها
- [ ] بررسی وجود کلید
- [ ] حذف کلید
- [ ] پاک کردن همه

### Open Settings Testing
- [ ] کلیک روی "Open Settings"
- [ ] بررسی باز شدن Settings
- [ ] فعال کردن مجوز
- [ ] بازگشت به برنامه
- [ ] بررسی مجدد وضعیت

## تست در Simulator

### نصب و اجرا
```bash
# لیست simulatorها
xcrun simctl list devices

# اجرا در simulator
flutter run -d <simulator-id>
```

### ریست کردن مجوزها
```bash
# ریست تمام مجوزها
xcrun simctl privacy booted reset all com.example.app

# ریست مجوز خاص
xcrun simctl privacy booted reset camera com.example.app
xcrun simctl privacy booted reset photos com.example.app
```

## تست در دستگاه واقعی

### پیش‌نیازها
1. حساب Apple Developer
2. Certificate و Provisioning Profile
3. دستگاه متصل به Mac

### اجرا
```bash
# لیست دستگاه‌ها
flutter devices

# اجرا در دستگاه
flutter run -d <device-id>
```

### بررسی مجوزها
1. Settings > Privacy & Security
2. انتخاب نوع مجوز (Camera, Photos, etc.)
3. پیدا کردن برنامه
4. بررسی وضعیت

## CI/CD Testing

### GitHub Actions

```yaml
name: Test

on: [push, pull_request]

jobs:
  test:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test
      - run: flutter analyze
```

## خطاهای رایج

### 1. Permission not in Info.plist

**خطا:**
```
This app has crashed because it attempted to access privacy-sensitive data 
without a usage description.
```

**راه‌حل:**
اضافه کردن توضیحات به `Info.plist`

### 2. Test fails on CI

**خطا:**
```
Test failed: No iOS devices available
```

**راه‌حل:**
استفاده از Mock Platform در تست‌ها

### 3. Permission always returns notDetermined

**خطا:**
مجوز همیشه `notDetermined` برمی‌گرداند

**راه‌حل:**
- بررسی Info.plist
- ریست کردن simulator
- بررسی کد Swift

## گزارش باگ

اگر مشکلی پیدا کردید:

1. **بررسی کنید:**
   - Info.plist کامل است؟
   - کد Swift صحیح است؟
   - تست‌ها pass می‌شوند؟

2. **اطلاعات جمع‌آوری:**
   - نسخه iOS
   - نسخه Flutter
   - لاگ‌های خطا
   - مراحل بازتولید

3. **ایجاد Issue:**
   - عنوان واضح
   - توضیحات کامل
   - کد نمونه
   - اسکرین‌شات

## منابع

- [Flutter Testing](https://docs.flutter.dev/testing)
- [iOS Testing](https://developer.apple.com/documentation/xctest)
- [README.md](README.md)
- [EXAMPLES.md](EXAMPLES.md)

## خلاصه

✅ Unit tests برای تست کد Dart  
✅ Integration tests برای تست واقعی  
✅ Manual testing برای تست UI/UX  
✅ Simulator testing برای توسعه سریع  
✅ Device testing برای تست نهایی  

**همه تست‌ها باید قبل از release اجرا شوند!**
