# راهنمای ایجاد Release در GitHub

## ✅ فایل‌ها با موفقیت آپلود شدند!

تمام فایل‌های پروژه به GitHub آپلود شدند:
- 📦 Repository: https://github.com/SwanFlutter/permission_master_ios
- 🏷️ Tag: v0.0.1
- 📝 Commits: 2 commit

---

## مراحل ایجاد Release در GitHub

### 1. رفتن به صفحه Releases

1. برو به: https://github.com/SwanFlutter/permission_master_ios
2. کلیک روی **"Releases"** در سمت راست
3. کلیک روی **"Create a new release"**

### 2. انتخاب Tag

- **Choose a tag:** v0.0.1 (از لیست انتخاب کنید)
- یا اگر نیست، تایپ کنید: `v0.0.1`

### 3. عنوان Release

```
Permission Master iOS v0.0.1 - Initial Release
```

### 4. توضیحات Release

این متن را کپی کنید:

```markdown
# 🎉 Permission Master iOS - نسخه اولیه

پلاگین جامع مدیریت مجوزهای iOS برای Flutter با قابلیت ذخیره‌سازی داده.

## ✨ ویژگی‌ها

### 13 مجوز iOS
- ✅ Camera (دوربین)
- ✅ Photos (کتابخانه عکس با Limited Access)
- ✅ Microphone (میکروفون)
- ✅ Location (موقعیت مکانی)
- ✅ Contacts (مخاطبین)
- ✅ Calendar (تقویم)
- ✅ Reminders (یادآورها)
- ✅ Notifications (اعلان‌ها)
- ✅ Bluetooth (بلوتوث)
- ✅ Motion & Fitness (حرکت و تناسب اندام)
- ✅ Speech Recognition (تشخیص گفتار)
- ✅ Media Library (کتابخانه موسیقی)
- ✅ Health (داده‌های سلامت)

### قابلیت‌های اضافی
- ✅ Check Permission Status - بررسی وضعیت بدون درخواست
- ✅ Open App Settings - باز کردن تنظیمات برای مجوزهای رد شده
- ✅ Storage - ذخیره‌سازی داده با UserDefaults
- ✅ Privacy Manifest - سازگار با App Store

### 8 وضعیت مجوز
- `granted` - داده شده
- `denied` - رد شده
- `restricted` - محدود شده
- `limited` - محدود (Photos)
- `notDetermined` - تعیین نشده
- `openSettings` - نیاز به تنظیمات
- `unsupported` - پشتیبانی نمی‌شود
- `error` - خطا

## 📦 نصب

```yaml
dependencies:
  permission_master_ios:
    git:
      url: https://github.com/SwanFlutter/permission_master_ios.git
      ref: v0.0.1
```

## 🚀 استفاده سریع

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

final plugin = PermissionMasterIos();

// درخواست مجوز دوربین
final status = await plugin.requestCameraPermission();

if (status == PermissionStatus.granted) {
  // مجوز داده شد
} else if (status == PermissionStatus.denied) {
  // باز کردن تنظیمات
  await plugin.openAppSettings();
}
```

## 📚 مستندات

- [README.md](README.md) - راهنمای کامل فارسی (34 KB)
- [EXAMPLES.md](EXAMPLES.md) - مثال‌های کامل برای هر مجوز (44 KB)
- [QUICK_START.md](QUICK_START.md) - شروع سریع (10 KB)
- [INFO_PLIST_GUIDE.md](INFO_PLIST_GUIDE.md) - راهنمای Info.plist (12 KB)
- [OPEN_SETTINGS_GUIDE.md](OPEN_SETTINGS_GUIDE.md) - راهنمای Open Settings (14 KB)
- [TESTING_GUIDE.md](TESTING_GUIDE.md) - راهنمای تست (8 KB)
- [APP_STORE_CHECKLIST.md](APP_STORE_CHECKLIST.md) - چک‌لیست App Store (5 KB)

## 🧪 تست‌ها

- ✅ 26 تست واحد - همه موفق
- ✅ پوشش تمام 13 مجوز
- ✅ تست تمام وضعیت‌ها
- ✅ 0 Warning - 0 Error

## 📊 آمار

- **کد Dart:** ~500 خط
- **کد Swift:** ~600 خط
- **مستندات:** ~150 KB
- **تست‌ها:** 26 تست
- **حجم Archive:** 73 KB

## 🔧 پیش‌نیازها

- Flutter 3.3.0+
- Dart 3.10.8+
- iOS 12.0+
- Xcode 14.0+

## 📝 Info.plist

برای استفاده از مجوزها، باید توضیحات را به `Info.plist` اضافه کنید:

```xml
<key>NSCameraUsageDescription</key>
<string>برنامه به دوربین نیاز دارد</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>برنامه به کتابخانه عکس نیاز دارد</string>

<!-- و بقیه مجوزها... -->
```

مراجعه کنید به [INFO_PLIST_GUIDE.md](INFO_PLIST_GUIDE.md) برای لیست کامل.

## 🎯 App Store Compliance

- ✅ Privacy Manifest (PrivacyInfo.xcprivacy)
- ✅ توضیحات مجوزها
- ✅ iOS 12.0+ پشتیبانی
- ✅ بدون API های Deprecated

## 🤝 مشارکت

مشارکت‌ها خوش‌آمدید! لطفاً:
1. Fork کنید
2. Branch جدید ایجاد کنید
3. تغییرات را commit کنید
4. Pull Request ایجاد کنید

## 📄 مجوز

MIT License - مشاهده [LICENSE](LICENSE)

## 🐛 گزارش باگ

اگر مشکلی پیدا کردید، لطفاً [Issue](https://github.com/SwanFlutter/permission_master_ios/issues) ایجاد کنید.

## 📧 تماس

- GitHub: [@SwanFlutter](https://github.com/SwanFlutter)
- Repository: [permission_master_ios](https://github.com/SwanFlutter/permission_master_ios)

---

**موفق باشید!** 🚀
```

### 5. انتشار Release

1. **Set as the latest release** را تیک بزنید
2. کلیک روی **"Publish release"**

---

## ✅ چک‌لیست نهایی

- [x] فایل‌ها به GitHub آپلود شدند
- [x] Tag v0.0.1 ایجاد شد
- [x] pubspec.yaml به‌روز شد
- [ ] Release در GitHub ایجاد شود
- [ ] README در صفحه اصلی نمایش داده شود

---

## 📦 نصب از GitHub

بعد از ایجاد Release، کاربران می‌توانند با این روش نصب کنند:

### روش 1: از طریق Git

```yaml
dependencies:
  permission_master_ios:
    git:
      url: https://github.com/SwanFlutter/permission_master_ios.git
      ref: v0.0.1
```

### روش 2: از طریق Tag

```yaml
dependencies:
  permission_master_ios:
    git:
      url: https://github.com/SwanFlutter/permission_master_ios.git
      ref: v0.0.1
```

### روش 3: از Branch

```yaml
dependencies:
  permission_master_ios:
    git:
      url: https://github.com/SwanFlutter/permission_master_ios.git
      ref: main
```

---

## 🚀 مراحل بعدی

### 1. ایجاد Release در GitHub
- رفتن به https://github.com/SwanFlutter/permission_master_ios/releases/new
- پر کردن فرم با اطلاعات بالا
- انتشار Release

### 2. تست نصب
```bash
# ایجاد پروژه تست
flutter create test_app
cd test_app

# اضافه کردن به pubspec.yaml
# dependencies:
#   permission_master_ios:
#     git:
#       url: https://github.com/SwanFlutter/permission_master_ios.git
#       ref: v0.0.1

flutter pub get
flutter run
```

### 3. اشتراک‌گذاری
- توییت کردن
- پست در Reddit (r/FlutterDev)
- پست در LinkedIn
- اضافه کردن به awesome-flutter

### 4. انتشار در pub.dev (اختیاری)

اگر می‌خواهید در pub.dev منتشر کنید:

```bash
flutter pub publish
```

---

## 📊 وضعیت فعلی

✅ **همه چیز آماده است!**

- Repository: https://github.com/SwanFlutter/permission_master_ios
- Tag: v0.0.1
- Files: 102 فایل
- Size: 91.29 KB
- Commits: 2
- Tests: 26 (همه موفق)
- Documentation: 11 فایل (150 KB)

**فقط باید Release را در GitHub ایجاد کنید!**

---

## 🎉 تبریک!

پلاگین شما با موفقیت به GitHub آپلود شد و آماده استفاده است!

**لینک Repository:**
https://github.com/SwanFlutter/permission_master_ios

**موفق باشید!** 🚀
