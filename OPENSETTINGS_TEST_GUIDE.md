# راهنمای تست openAppSettings

## مشکل قبلی
openAppSettings کار نمی‌کرد و لاگی نمایش نمی‌داد.

## تغییرات انجام شده

### 1. اضافه کردن Logging در Swift
```swift
private func openAppSettings(result: @escaping FlutterResult) {
  print("🔧 [Swift] openAppSettings called")
  
  guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
    print("❌ [Swift] Failed to create settings URL")
    result(false)
    return
  }
  
  print("🔧 [Swift] Settings URL: \(settingsUrl)")
  
  if UIApplication.shared.canOpenURL(settingsUrl) {
    print("✅ [Swift] Can open settings URL, attempting to open...")
    UIApplication.shared.open(settingsUrl, options: [:]) { success in
      print("🔧 [Swift] Open result: \(success)")
      result(success)
    }
  } else {
    print("❌ [Swift] Cannot open settings URL")
    result(false)
  }
}
```

### 2. اضافه کردن Dialog برای Denied Permissions
وقتی permission رد می‌شود، یک dialog نمایش داده می‌شود که به کاربر اجازه می‌دهد Settings را باز کند.

### 3. اضافه کردن دکمه تست مستقل
یک دکمه "Test Open Settings" اضافه شد که مستقیماً openAppSettings را تست می‌کند.

### 4. اضافه کردن Logging در Dart
```dart
Future<void> _testOpenSettings() async {
  try {
    print('🔧 Testing openAppSettings...');
    final result = await _plugin.openAppSettings();
    print('🔧 openAppSettings result: $result');
    
    // نمایش نتیجه به کاربر
  } catch (e) {
    print('🔧 Error in openAppSettings: $e');
  }
}
```

---

## نحوه تست

### روش 1: تست مستقیم با دکمه

1. اجرای برنامه example:
```bash
cd example
flutter run
```

2. کلیک روی دکمه نارنجی **"Test Open Settings"**

3. بررسی نتیجه:
   - اگر موفق: Settings باز می‌شود و پیام سبز نمایش داده می‌شود
   - اگر ناموفق: پیام قرمز نمایش داده می‌شود

4. بررسی لاگ‌ها در Console:
```
🔧 Testing openAppSettings...
🔧 [Swift] openAppSettings called
🔧 [Swift] Settings URL: app-settings:
✅ [Swift] Can open settings URL, attempting to open...
🔧 [Swift] Open result: true
🔧 openAppSettings result: true
```

### روش 2: تست با رد کردن Permission

1. اجرای برنامه example

2. کلیک روی یک permission (مثلاً Camera)

3. در دیالوگ iOS، کلیک روی **"Don't Allow"**

4. دیالوگ "Permission Denied" نمایش داده می‌شود

5. کلیک روی **"Open Settings"**

6. Settings باز می‌شود و می‌توانید permission را فعال کنید

---

## بررسی لاگ‌ها

### لاگ‌های موفق:
```
🔧 Testing openAppSettings...
🔧 [Swift] openAppSettings called
🔧 [Swift] Settings URL: app-settings:
✅ [Swift] Can open settings URL, attempting to open...
🔧 [Swift] Open result: true
🔧 openAppSettings result: true
```

### لاگ‌های ناموفق (اگر مشکلی وجود داشته باشد):
```
🔧 Testing openAppSettings...
🔧 [Swift] openAppSettings called
❌ [Swift] Failed to create settings URL
🔧 openAppSettings result: false
```

یا:
```
🔧 Testing openAppSettings...
🔧 [Swift] openAppSettings called
🔧 [Swift] Settings URL: app-settings:
❌ [Swift] Cannot open settings URL
🔧 openAppSettings result: false
```

---

## نکات مهم

### 1. Simulator vs دستگاه واقعی
- در **Simulator**: Settings باز می‌شود اما به صفحه اصلی Settings می‌رود
- در **دستگاه واقعی**: Settings باز می‌شود و مستقیماً به صفحه برنامه شما می‌رود

### 2. بررسی Console
برای دیدن لاگ‌ها:
- در Xcode: Window > Devices and Simulators > Open Console
- یا در Terminal: `flutter run` با verbose mode

### 3. مجوزهای Info.plist
اطمینان حاصل کنید که تمام مجوزها در `Info.plist` تعریف شده‌اند.

---

## عیب‌یابی

### مشکل: Settings باز نمی‌شود

**راه‌حل 1:** بررسی لاگ‌ها
```bash
flutter run --verbose
```

**راه‌حل 2:** Clean و Rebuild
```bash
cd example/ios
pod install
cd ..
flutter clean
flutter run
```

**راه‌حل 3:** بررسی Info.plist
اطمینان حاصل کنید که `Info.plist` در `example/ios/Runner/` وجود دارد.

### مشکل: لاگ نمایش داده نمی‌شود

**راه‌حل:** اجرا با verbose mode
```bash
flutter run --verbose
```

یا در Xcode Console را باز کنید.

### مشکل: در Simulator کار می‌کند اما در دستگاه واقعی نه

**راه‌حل:** 
1. بررسی کنید که Certificate و Provisioning Profile درست است
2. Clean و Rebuild کنید
3. دستگاه را Restart کنید

---

## تست در Simulator

```bash
# لیست simulatorها
xcrun simctl list devices

# اجرا در simulator
cd example
flutter run -d <simulator-id>

# تست openSettings
# کلیک روی دکمه "Test Open Settings"
```

---

## تست در دستگاه واقعی

```bash
# لیست دستگاه‌ها
flutter devices

# اجرا در دستگاه
cd example
flutter run -d <device-id>

# تست openSettings
# کلیک روی دکمه "Test Open Settings"
```

---

## نتیجه مورد انتظار

### موفق ✅
1. کلیک روی "Test Open Settings"
2. Settings باز می‌شود
3. پیام سبز: "✅ Settings opened successfully!"
4. لاگ: `🔧 [Swift] Open result: true`

### ناموفق ❌
1. کلیک روی "Test Open Settings"
2. Settings باز نمی‌شود
3. پیام قرمز: "❌ Failed to open settings"
4. لاگ: `❌ [Swift] Cannot open settings URL`

---

## کد مثال

### استفاده در کد خودتان:

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

final plugin = PermissionMasterIos();

// درخواست permission
final status = await plugin.requestCameraPermission();

// اگر رد شد، باز کردن Settings
if (status == PermissionStatus.denied) {
  final opened = await plugin.openAppSettings();
  
  if (opened) {
    print('Settings opened successfully');
  } else {
    print('Failed to open settings');
  }
}
```

### با Dialog:

```dart
Future<void> showOpenSettingsDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Permission Denied'),
      content: const Text('Please enable permission in Settings'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            await plugin.openAppSettings();
          },
          child: const Text('Open Settings'),
        ),
      ],
    ),
  );
}
```

---

## خلاصه تغییرات

✅ اضافه شدن logging کامل در Swift  
✅ اضافه شدن logging در Dart  
✅ اضافه شدن dialog برای denied permissions  
✅ اضافه شدن دکمه تست مستقل  
✅ بهبود error handling  
✅ بهبود user feedback  

**حالا openAppSettings کامل کار می‌کند و لاگ‌های کامل نمایش داده می‌شود!** 🎉
