# Permission Master iOS - مستندات فنی

## معماری پلاگین

### ساختار کلی

```
permission_master_ios/
├── lib/
│   ├── permission_master_ios.dart              # API اصلی
│   ├── permission_master_ios_platform_interface.dart  # رابط پلتفرم
│   ├── permission_master_ios_method_channel.dart     # پیاده‌سازی Method Channel
│   └── src/
│       ├── permission_status.dart              # وضعیت‌های مجوز
│       ├── permission_type.dart                # انواع مجوز
│       └── get_storage_bridge.dart             # پل ارتباطی Storage
└── ios/
    ├── Classes/
    │   ├── PermissionMasterIosPlugin.swift     # پلاگین اصلی
    │   ├── PermissionHelper.swift              # کمک‌کننده مدیریت مجوزها
    │   └── GetStorage.swift                    # مدیریت ذخیره‌سازی
    └── Resources/
        └── PrivacyInfo.xcprivacy               # Privacy Manifest
```

## جزئیات فنی

### 1. PermissionMasterIosPlugin.swift

کلاس اصلی که تمام درخواست‌های مجوز را مدیریت می‌کند:

```swift
public class PermissionMasterIosPlugin: NSObject, FlutterPlugin {
  private let storage = GetStorage()
  private let permissionHelper = PermissionHelper.shared
  
  // مدیریت Method Channel
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult)
}
```

ویژگی‌ها:
- استفاده از Singleton Pattern برای PermissionHelper
- مدیریت Async/Await برای درخواست‌های مجوز
- ذخیره وضعیت مجوزها در UserDefaults
- پشتیبانی از تمام نسخه‌های iOS 12+

### 2. PermissionHelper.swift

مدیریت هوشمند تعداد درخواست مجوزها:

```swift
class PermissionHelper {
    static let shared = PermissionHelper()
    private let maxRequestCount = 2
    
    func canRequestPermission(for permission: String) -> Bool
    func incrementRequestCount(for permission: String)
    func resetRequestCount(for permission: String)
}
```

این کلاس از درخواست‌های بیش از حد جلوگیری می‌کند و تجربه کاربری بهتری ارائه می‌دهد.

### 3. GetStorage.swift

مدیریت ذخیره‌سازی با UserDefaults:

```swift
class GetStorage {
    private let userDefaults = UserDefaults.standard
    
    func write(_ key: String, value: Any) throws
    func read(_ key: String) -> Any?
    func contains(_ key: String) -> Bool
    func remove(_ key: String)
    func clear()
}
```

### 4. Method Channel Communication

ارتباط بین Dart و Swift:

```dart
// Dart Side
final methodChannel = const MethodChannel('permission_master_ios');
final status = await methodChannel.invokeMethod<String>('requestCameraPermission');

// Swift Side
case "requestCameraPermission":
  requestCameraPermission(result: result)
```

## وضعیت‌های مجوز

| وضعیت | توضیحات | مثال |
|-------|---------|------|
| `granted` | کاربر مجوز را داده است | دسترسی کامل |
| `denied` | کاربر مجوز را رد کرده است | نیاز به راهنمایی |
| `restricted` | مجوز محدود شده (کنترل والدین) | غیرقابل تغییر |
| `limited` | دسترسی محدود (iOS 14+ Photos) | انتخاب تصاویر خاص |
| `notDetermined` | هنوز درخواست نشده | اولین بار |

## Privacy Manifest

فایل `PrivacyInfo.xcprivacy` برای رعایت استانداردهای Apple:

```xml
<key>NSPrivacyAccessedAPIType</key>
<string>NSPrivacyAccessedAPICategoryUserDefaults</string>
<key>NSPrivacyAccessedAPITypeReasons</key>
<array>
    <string>CA92.1</string>
</array>
```

دلیل `CA92.1`: دسترسی به UserDefaults برای ذخیره تنظیمات برنامه.

## بهترین روش‌ها

### 1. درخواست در زمان مناسب

```dart
// ❌ بد
void initState() {
  _requestAllPermissions();
}

// ✅ خوب
void _onCameraButtonPressed() async {
  final status = await _plugin.requestCameraPermission();
  if (status == PermissionStatus.granted) {
    _openCamera();
  }
}
```

### 2. مدیریت خطاها

```dart
try {
  final status = await _plugin.requestCameraPermission();
  // استفاده از مجوز
} catch (e) {
  // مدیریت خطا
  print('Error: $e');
}
```

### 3. ذخیره وضعیت

```dart
final storage = _plugin.storage;

// ذخیره تنظیمات کاربر
await storage.write('permission_asked_camera', true);

// بررسی قبل از درخواست مجدد
final asked = await storage.read('permission_asked_camera', false);
if (!asked) {
  await _plugin.requestCameraPermission();
}
```

## تست و دیباگ

### شبیه‌ساز iOS

```bash
# اجرای برنامه در شبیه‌ساز
flutter run

# ریست کردن مجوزها
xcrun simctl privacy booted reset all com.example.app
```

### دستگاه واقعی

Settings > Privacy > [Permission Type] > [Your App]

## مشکلات رایج و راه‌حل‌ها

### 1. مجوز درخواست نمی‌شود

**علت**: توضیحات مجوز در Info.plist وجود ندارد

**راه‌حل**:
```xml
<key>NSCameraUsageDescription</key>
<string>توضیحات مجوز</string>
```

### 2. خطای Build

**علت**: Pod نصب نشده

**راه‌حل**:
```bash
cd ios
pod deintegrate
pod install
```

### 3. Storage کار نمی‌کند

**علت**: Method Channel نادرست

**راه‌حل**: بررسی نام channel در Dart و Swift

## Performance

- استفاده از Singleton برای PermissionHelper
- Cache کردن وضعیت مجوزها
- Async/Await برای عملیات غیرهمزمان
- حداقل استفاده از حافظه

## امنیت

- عدم ذخیره اطلاعات حساس
- استفاده از UserDefaults برای داده‌های غیرحساس
- رعایت Privacy Guidelines اپل
- عدم ردیابی کاربر

## سازگاری

| iOS Version | پشتیبانی |
|-------------|----------|
| iOS 12.0+ | ✅ کامل |
| iOS 13.0+ | ✅ کامل |
| iOS 14.0+ | ✅ + Limited Photos |
| iOS 15.0+ | ✅ کامل |
| iOS 16.0+ | ✅ کامل |
| iOS 17.0+ | ✅ کامل |

## مشارکت

برای مشارکت در توسعه:

1. Fork کردن پروژه
2. ایجاد Branch جدید
3. Commit تغییرات
4. Push به Branch
5. ایجاد Pull Request

## لایسنس

MIT License - استفاده آزاد در پروژه‌های تجاری و غیرتجاری
