# راهنمای Health Permission

## ⚠️ نکته مهم
**Health permission فقط روی دستگاه واقعی iOS کار می‌کند، نه Simulator!**

---

## مشکل قبلی
Health permission همیشه "denied" برمی‌گرداند و تایید نمی‌شود.

## علت مشکل

### 1. محدودیت Simulator
Health app و HealthKit فقط روی دستگاه واقعی iOS کار می‌کنند. در Simulator:
- `HKHealthStore.isHealthDataAvailable()` معمولاً `false` برمی‌گرداند
- یا اگر `true` باشد، authorization همیشه fail می‌شود

### 2. کد قبلی محدود بود
کد قبلی فقط `workoutType` را درخواست می‌کرد که خیلی محدود است.

---

## تغییرات انجام شده

### 1. اضافه کردن انواع بیشتر Health Data

```swift
let readTypes: Set<HKObjectType> = [
  HKObjectType.workoutType(),
  HKObjectType.quantityType(forIdentifier: .stepCount)!,
  HKObjectType.quantityType(forIdentifier: .heartRate)!,
  HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
  HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
]

let writeTypes: Set<HKSampleType> = [
  HKObjectType.workoutType(),
  HKObjectType.quantityType(forIdentifier: .stepCount)!,
]
```

### 2. اضافه کردن Logging

```swift
print("🔧 [Swift] requestHealthPermission called")
print("🔧 [Swift] Requesting Health authorization...")
print("✅ [Swift] Health authorization success: \(success)")
print("🔧 [Swift] Health status: \(status.rawValue)")
```

### 3. بهبود Error Handling

```swift
if let error = error {
  print("❌ [Swift] Health authorization error: \(error.localizedDescription)")
  result("denied")
  return
}
```

### 4. اضافه کردن checkPermissionStatus برای Health

```swift
case "health":
  if !HKHealthStore.isHealthDataAvailable() {
    result("unsupported")
  } else {
    let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount)!
    let status = healthStore.authorizationStatus(for: stepCountType)
    result(mapHealthStatus(status))
  }
```

---

## نحوه تست

### ❌ در Simulator (کار نمی‌کند)

```bash
cd example
flutter run -d <simulator-id>
```

**نتیجه:** "unsupported" یا "denied"

### ✅ در دستگاه واقعی (کار می‌کند)

```bash
# اتصال دستگاه به Mac
# فعال کردن Developer Mode در دستگاه

# لیست دستگاه‌ها
flutter devices

# اجرا در دستگاه
cd example
flutter run -d <device-id>
```

**مراحل:**
1. کلیک روی "Health" در برنامه
2. صفحه Health باز می‌شود
3. انتخاب داده‌هایی که می‌خواهید اشتراک بگذارید:
   - Steps (قدم‌ها)
   - Heart Rate (ضربان قلب)
   - Workouts (تمرینات)
   - Active Energy (انرژی فعال)
   - Walking + Running Distance (مسافت پیاده‌روی و دویدن)
4. کلیک روی "Allow"
5. وضعیت به "granted" تغییر می‌کند

---

## لاگ‌های مورد انتظار

### در Simulator:
```
🔧 [Swift] requestHealthPermission called
❌ [Swift] Health data not available on this device
```

### در دستگاه واقعی (موفق):
```
🔧 [Swift] requestHealthPermission called
🔧 [Swift] Requesting Health authorization...
✅ [Swift] Health authorization success: true
🔧 [Swift] Health status: 2
```

### در دستگاه واقعی (رد شده):
```
🔧 [Swift] requestHealthPermission called
🔧 [Swift] Requesting Health authorization...
✅ [Swift] Health authorization success: false
🔧 [Swift] Health status: 1
```

---

## Info.plist

اطمینان حاصل کنید که این کلیدها در `Info.plist` وجود دارند:

```xml
<!-- Health Data Permissions -->
<key>NSHealthShareUsageDescription</key>
<string>This app needs to read your health data to track your wellness</string>

<key>NSHealthUpdateUsageDescription</key>
<string>This app needs to update your health data to record your activities</string>
```

---

## Health Status Values

```swift
case notDetermined = 0  // هنوز درخواست نشده
case sharingDenied = 1  // رد شده
case sharingAuthorized = 2  // تایید شده
```

---

## نکات مهم

### 1. فقط دستگاه واقعی
Health فقط روی iPhone واقعی کار می‌کند. در Simulator همیشه "unsupported" یا "denied" برمی‌گرداند.

### 2. Privacy در iOS
iOS به کاربران اجازه می‌دهد برای هر نوع داده به صورت جداگانه مجوز بدهند. مثلاً:
- Steps: Allow
- Heart Rate: Don't Allow

### 3. Authorization Status
HealthKit به شما نمی‌گوید که کاربر دقیقاً چه داده‌هایی را رد کرده. این برای حفظ حریم خصوصی است.

### 4. Testing
برای تست کامل، باید:
- دستگاه واقعی داشته باشید
- Health app روی دستگاه نصب باشد
- داده‌های Health در دستگاه وجود داشته باشد

---

## عیب‌یابی

### مشکل: "unsupported" برمی‌گرداند

**راه‌حل:**
- روی دستگاه واقعی تست کنید
- Simulator پشتیبانی نمی‌کند

### مشکل: "denied" برمی‌گرداند

**راه‌حل 1:** بررسی Info.plist
```xml
<key>NSHealthShareUsageDescription</key>
<string>توضیحات واضح</string>
```

**راه‌حل 2:** ریست کردن مجوزها
```
Settings > Privacy & Security > Health > [Your App] > Delete All Data
```

**راه‌حل 3:** Uninstall و Reinstall
```bash
# حذف برنامه از دستگاه
# سپس اجرا مجدد
flutter run -d <device-id>
```

### مشکل: صفحه Health باز نمی‌شود

**راه‌حل:**
- اطمینان حاصل کنید که Health app روی دستگاه نصب است
- بعضی کشورها یا نسخه‌های iOS ممکن است Health نداشته باشند

---

## کد مثال

### درخواست ساده:

```dart
final plugin = PermissionMasterIos();

final status = await plugin.requestHealthPermission();

if (status == PermissionStatus.granted) {
  print('✅ Health permission granted');
} else if (status == PermissionStatus.denied) {
  print('❌ Health permission denied');
} else if (status == PermissionStatus.unsupported) {
  print('⚠️ Health not available (Simulator?)');
}
```

### با بررسی Platform:

```dart
import 'dart:io';

Future<void> requestHealth() async {
  if (!Platform.isIOS) {
    print('Health only available on iOS');
    return;
  }
  
  final plugin = PermissionMasterIos();
  final status = await plugin.requestHealthPermission();
  
  if (status == PermissionStatus.unsupported) {
    print('⚠️ Please test on a real device, not Simulator');
    return;
  }
  
  // استفاده از مجوز
}
```

### با Dialog:

```dart
Future<void> requestHealthWithDialog(BuildContext context) async {
  final plugin = PermissionMasterIos();
  final status = await plugin.requestHealthPermission();
  
  if (status == PermissionStatus.unsupported) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Not Available'),
        content: const Text(
          'Health data is only available on real iOS devices. '
          'Please test on an iPhone, not Simulator.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  } else if (status == PermissionStatus.granted) {
    // استفاده از داده‌های Health
  }
}
```

---

## انواع داده‌های Health پشتیبانی شده

در حال حاضر این انواع پشتیبانی می‌شوند:

### Read (خواندن):
- ✅ Workouts (تمرینات)
- ✅ Step Count (تعداد قدم‌ها)
- ✅ Heart Rate (ضربان قلب)
- ✅ Active Energy Burned (انرژی فعال سوزانده شده)
- ✅ Walking + Running Distance (مسافت پیاده‌روی و دویدن)

### Write (نوشتن):
- ✅ Workouts (تمرینات)
- ✅ Step Count (تعداد قدم‌ها)

### اضافه کردن انواع بیشتر:

اگر می‌خواهید انواع بیشتری اضافه کنید، در `PermissionMasterIosPlugin.swift`:

```swift
let readTypes: Set<HKObjectType> = [
  // موارد فعلی...
  HKObjectType.quantityType(forIdentifier: .bodyMass)!,  // وزن
  HKObjectType.quantityType(forIdentifier: .height)!,    // قد
  HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,  // خواب
]
```

---

## خلاصه

✅ کد بهبود یافت با انواع بیشتر Health data  
✅ Logging کامل اضافه شد  
✅ Error handling بهبود یافت  
✅ checkPermissionStatus برای Health اضافه شد  
⚠️ **فقط روی دستگاه واقعی کار می‌کند**  

**برای تست Health permission، حتماً از iPhone واقعی استفاده کنید!** 📱
