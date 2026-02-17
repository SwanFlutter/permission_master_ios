# راهنمای تنظیم Info.plist برای Permission Master iOS

این راهنما نحوه تنظیم فایل `Info.plist` برای استفاده از تمام 13 مجوز را توضیح می‌دهد.

## مکان فایل

```
ios/Runner/Info.plist
```

## تنظیمات کامل

فایل `Info.plist` خود را باز کنید و این کلیدها را اضافه کنید:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- محتوای موجود شما ... -->
    
    <!-- ==================== PERMISSION DESCRIPTIONS ==================== -->
    
    <!-- 1. 📷 Camera Permission -->
    <key>NSCameraUsageDescription</key>
    <string>This app needs camera access to take photos and record videos</string>
    
    <!-- 2. 🖼️ Photo Library Permissions -->
    <key>NSPhotoLibraryUsageDescription</key>
    <string>This app needs access to your photo library to select and view photos</string>
    <key>NSPhotoLibraryAddUsageDescription</key>
    <string>This app needs permission to save photos to your photo library</string>
    
    <!-- 3. 🎤 Microphone Permission -->
    <key>NSMicrophoneUsageDescription</key>
    <string>This app needs microphone access to record audio</string>
    
    <!-- 4. 📍 Location Permissions -->
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>This app needs your location to show nearby places</string>
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
    <string>This app needs your location to track your activity</string>
    <key>NSLocationAlwaysUsageDescription</key>
    <string>This app needs continuous location access for background tracking</string>
    
    <!-- 5. 👥 Contacts Permission -->
    <key>NSContactsUsageDescription</key>
    <string>This app needs access to your contacts to help you connect with friends</string>
    
    <!-- 6. 📅 Calendar Permission -->
    <key>NSCalendarsUsageDescription</key>
    <string>This app needs access to your calendar to manage events</string>
    
    <!-- 7. ⏰ Reminders Permission -->
    <key>NSRemindersUsageDescription</key>
    <string>This app needs access to your reminders to create and manage tasks</string>
    
    <!-- 8. 📶 Bluetooth Permissions -->
    <key>NSBluetoothAlwaysUsageDescription</key>
    <string>This app needs Bluetooth access to connect to nearby devices</string>
    <key>NSBluetoothPeripheralUsageDescription</key>
    <string>This app needs Bluetooth access to communicate with accessories</string>
    
    <!-- 9. 🏃 Motion & Fitness Permission -->
    <key>NSMotionUsageDescription</key>
    <string>This app needs motion access to track your physical activity and fitness</string>
    
    <!-- 10. 🗣️ Speech Recognition Permission -->
    <key>NSSpeechRecognitionUsageDescription</key>
    <string>This app needs speech recognition to convert your voice to text</string>
    
    <!-- 11. 🎵 Media Library Permission -->
    <key>NSAppleMusicUsageDescription</key>
    <string>This app needs access to your music library to play songs</string>
    <key>kTCCServiceMediaLibrary</key>
    <string>This app needs access to your media library</string>
    
    <!-- 12. ❤️ Health Data Permissions -->
    <key>NSHealthShareUsageDescription</key>
    <string>This app needs to read your health data to track your wellness</string>
    <key>NSHealthUpdateUsageDescription</key>
    <string>This app needs to update your health data to record your activities</string>
    
    <!-- ==================== END PERMISSIONS ==================== -->
</dict>
</plist>
```

## توضیحات هر مجوز

### 1. Camera (دوربین)

```xml
<key>NSCameraUsageDescription</key>
<string>توضیحات شما</string>
```

**مثال‌های خوب:**
- "برای گرفتن عکس پروفایل به دوربین نیاز داریم"
- "این برنامه برای اسکن QR Code به دوربین نیاز دارد"
- "برای ضبط ویدیو و عکس‌برداری نیاز است"

### 2. Photos (کتابخانه تصاویر)

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>برای انتخاب تصاویر</string>

<key>NSPhotoLibraryAddUsageDescription</key>
<string>برای ذخیره تصاویر</string>
```

**مثال‌های خوب:**
- "برای انتخاب عکس از گالری نیاز است"
- "برای ذخیره عکس‌های ویرایش شده نیاز است"

### 3. Microphone (میکروفون)

```xml
<key>NSMicrophoneUsageDescription</key>
<string>توضیحات شما</string>
```

**مثال‌های خوب:**
- "برای ضبط صدا و تماس صوتی نیاز است"
- "برای ارسال پیام صوتی به میکروفون نیاز داریم"

### 4. Location (موقعیت مکانی)

```xml
<!-- استفاده در حین استفاده از برنامه -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>توضیحات شما</string>

<!-- استفاده همیشگی (پس‌زمینه) -->
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>توضیحات شما</string>

<!-- برای iOS 10 و پایین‌تر -->
<key>NSLocationAlwaysUsageDescription</key>
<string>توضیحات شما</string>
```

**مثال‌های خوب:**
- "برای نمایش مکان‌های نزدیک شما نیاز است"
- "برای ردیابی مسیر ورزشی شما نیاز است"

### 5. Contacts (مخاطبین)

```xml
<key>NSContactsUsageDescription</key>
<string>توضیحات شما</string>
```

**مثال‌های خوب:**
- "برای دعوت دوستان از مخاطبین نیاز است"
- "برای نمایش مخاطبین در برنامه نیاز است"

### 6. Calendar (تقویم)

```xml
<key>NSCalendarsUsageDescription</key>
<string>توضیحات شما</string>
```

**مثال‌های خوب:**
- "برای ایجاد یادآور رویدادها نیاز است"
- "برای همگام‌سازی قرار ملاقات‌ها نیاز است"

### 7. Reminders (یادآورها)

```xml
<key>NSRemindersUsageDescription</key>
<string>توضیحات شما</string>
```

**مثال‌های خوب:**
- "برای ایجاد یادآور وظایف نیاز است"
- "برای مدیریت لیست کارها نیاز است"

### 8. Bluetooth (بلوتوث)

```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>توضیحات شما</string>

<key>NSBluetoothPeripheralUsageDescription</key>
<string>توضیحات شما</string>
```

**مثال‌های خوب:**
- "برای اتصال به دستگاه‌های هوشمند نیاز است"
- "برای ارتباط با ساعت هوشمند نیاز است"

### 9. Motion (حرکت و فیتنس)

```xml
<key>NSMotionUsageDescription</key>
<string>توضیحات شما</string>
```

**مثال‌های خوب:**
- "برای شمارش قدم‌ها نیاز است"
- "برای ردیابی فعالیت ورزشی نیاز است"

### 10. Speech Recognition (تشخیص گفتار)

```xml
<key>NSSpeechRecognitionUsageDescription</key>
<string>توضیحات شما</string>
```

**مثال‌های خوب:**
- "برای تبدیل گفتار به متن نیاز است"
- "برای دستیار صوتی نیاز است"

### 11. Media Library (کتابخانه موسیقی)

```xml
<key>NSAppleMusicUsageDescription</key>
<string>توضیحات شما</string>

<key>kTCCServiceMediaLibrary</key>
<string>توضیحات شما</string>
```

**مثال‌های خوب:**
- "برای پخش موسیقی از کتابخانه شما نیاز است"
- "برای دسترسی به آهنگ‌های شما نیاز است"

### 12. Health (داده‌های سلامت)

```xml
<key>NSHealthShareUsageDescription</key>
<string>توضیحات شما</string>

<key>NSHealthUpdateUsageDescription</key>
<string>توضیحات شما</string>
```

**مثال‌های خوب:**
- "برای خواندن داده‌های سلامت شما نیاز است"
- "برای ثبت فعالیت‌های ورزشی نیاز است"

## نکات مهم

### ✅ انجام دهید:

1. **توضیحات واضح و صادقانه**
   ```xml
   <!-- ✅ خوب -->
   <string>برای گرفتن عکس پروفایل به دوربین نیاز داریم</string>
   
   <!-- ❌ بد -->
   <string>برنامه به دوربین نیاز دارد</string>
   ```

2. **فقط مجوزهای مورد نیاز**
   - فقط مجوزهایی که واقعاً استفاده می‌کنید را اضافه کنید
   - مجوزهای اضافی باعث رد شدن در App Store می‌شود

3. **زبان ساده**
   ```xml
   <!-- ✅ خوب -->
   <string>برای ذخیره عکس‌ها در گالری شما</string>
   
   <!-- ❌ بد -->
   <string>برای دسترسی به سیستم فایل تصاویر دستگاه</string>
   ```

### ❌ انجام ندهید:

1. **توضیحات مبهم**
   ```xml
   <!-- ❌ بد -->
   <string>برای عملکرد بهتر</string>
   <string>برنامه نیاز دارد</string>
   ```

2. **توضیحات خیلی طولانی**
   ```xml
   <!-- ❌ بد -->
   <string>این برنامه برای انجام عملیات مختلف از جمله گرفتن عکس، ضبط ویدیو، اسکن QR Code و سایر موارد به دوربین نیاز دارد...</string>
   ```

3. **مجوزهای غیرضروری**
   - اگر از Health استفاده نمی‌کنید، آن را اضافه نکنید

## بررسی قبل از Submit

### چک‌لیست:

- [ ] فقط مجوزهای مورد استفاده اضافه شده‌اند
- [ ] تمام توضیحات واضح و قابل فهم هستند
- [ ] توضیحات به زبان ساده نوشته شده‌اند
- [ ] هیچ مجوز اضافی وجود ندارد
- [ ] تمام مجوزهای استفاده شده توضیح دارند

### تست در Simulator:

```bash
# اجرای برنامه
flutter run

# درخواست هر مجوز
# بررسی متن نمایش داده شده
```

### تست در دستگاه واقعی:

1. نصب برنامه روی iPhone
2. درخواست هر مجوز
3. بررسی متن نمایش داده شده
4. رد کردن و قبول کردن مجوز
5. بررسی Settings > Privacy

## مثال کامل برای یک برنامه Chat

```xml
<!-- برنامه چت نیاز به این مجوزها دارد -->

<!-- برای ارسال عکس -->
<key>NSCameraUsageDescription</key>
<string>برای گرفتن عکس و ارسال در چت</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>برای انتخاب عکس از گالری و ارسال در چت</string>

<!-- برای پیام صوتی -->
<key>NSMicrophoneUsageDescription</key>
<string>برای ضبط و ارسال پیام صوتی</string>

<!-- برای اشتراک موقعیت -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>برای اشتراک‌گذاری موقعیت مکانی با دوستان</string>

<!-- برای دعوت دوستان -->
<key>NSContactsUsageDescription</key>
<string>برای دعوت دوستان از مخاطبین به برنامه</string>

<!-- برای اعلان‌ها -->
<!-- این مجوز نیاز به Info.plist ندارد، فقط در کد درخواست می‌شود -->
```

## خطاهای رایج

### خطا 1: مجوز بدون توضیحات

```
This app has crashed because it attempted to access privacy-sensitive data 
without a usage description.
```

**راه‌حل:** اضافه کردن کلید مربوطه به Info.plist

### خطا 2: توضیحات خالی

```xml
<!-- ❌ اشتباه -->
<key>NSCameraUsageDescription</key>
<string></string>
```

**راه‌حل:** نوشتن توضیحات معنادار

### خطا 3: کلید اشتباه

```xml
<!-- ❌ اشتباه -->
<key>CameraUsageDescription</key>

<!-- ✅ درست -->
<key>NSCameraUsageDescription</key>
```

## منابع بیشتر

- [Apple Documentation - Requesting Access to Protected Resources](https://developer.apple.com/documentation/uikit/protecting_the_user_s_privacy/requesting_access_to_protected_resources)
- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [README.md](README.md) - راهنمای کامل پلاگین

## پشتیبانی

اگر سوالی دارید یا به کمک نیاز دارید، یک Issue در GitHub ایجاد کنید.
