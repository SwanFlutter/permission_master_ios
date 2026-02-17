# چک‌لیست تست دستی - Permission Master iOS

این چک‌لیست برای تست دستی پلاگین روی دستگاه واقعی یا Simulator است.

## پیش‌نیازها

- ✅ Flutter نصب شده
- ✅ Xcode نصب شده (برای iOS)
- ✅ Info.plist تنظیم شده
- ✅ Podfile موجود است

## نصب و اجرا

```bash
# 1. نصب dependencies
flutter pub get

# 2. نصب pods
cd example/ios
pod install
cd ../..

# 3. اجرا در simulator
cd example
flutter run

# یا اجرا در دستگاه واقعی
flutter run -d <device-id>
```

## تست‌های اجباری

### ✅ 1. Camera Permission

**مراحل:**
1. کلیک روی "Camera"
2. دیالوگ مجوز نمایش داده می‌شود
3. کلیک "Allow"
4. وضعیت به "granted" تغییر می‌کند

**نتیجه مورد انتظار:**
- ✅ دیالوگ با متن Info.plist نمایش داده شود
- ✅ بعد از Allow، وضعیت granted شود
- ✅ آیکون سبز نمایش داده شود

**تست رد کردن:**
1. کلیک روی "Camera" دوباره (uninstall و reinstall کنید)
2. کلیک "Don't Allow"
3. دیالوگ "Open Settings" نمایش داده شود
4. کلیک "Open Settings"
5. Settings باز شود

---

### ✅ 2. Photos Permission

**مراحل:**
1. کلیک روی "Photos"
2. دیالوگ با 3 گزینه نمایش داده می‌شود:
   - Select Photos (Limited)
   - Allow Access to All Photos
   - Don't Allow

**تست Limited Access:**
1. کلیک "Select Photos"
2. انتخاب چند عکس
3. وضعیت به "limited" تغییر می‌کند

**تست Full Access:**
1. Uninstall و reinstall
2. کلیک "Allow Access to All Photos"
3. وضعیت به "granted" تغییر می‌کند

---

### ✅ 3. Microphone Permission

**مراحل:**
1. کلیک روی "Microphone"
2. دیالوگ مجوز نمایش داده می‌شود
3. تست Allow و Don't Allow

---

### ✅ 4. Location Permission

**مراحل:**
1. کلیک روی "Location"
2. دیالوگ با گزینه‌ها:
   - Allow While Using App
   - Allow Once
   - Don't Allow

**تست:**
- Allow While Using App → granted
- Don't Allow → denied

---

### ✅ 5. Contacts Permission

**مراحل:**
1. کلیک روی "Contacts"
2. Allow/Don't Allow
3. بررسی وضعیت

---

### ✅ 6. Calendar Permission

**مراحل:**
1. کلیک روی "Calendar"
2. Allow/Don't Allow
3. بررسی وضعیت

---

### ✅ 7. Reminders Permission

**مراحل:**
1. کلیک روی "Reminders"
2. Allow/Don't Allow
3. بررسی وضعیت

---

### ✅ 8. Notifications Permission

**مراحل:**
1. کلیک روی "Notifications"
2. دیالوگ با گزینه‌ها:
   - Allow
   - Don't Allow

---

### ✅ 9. Bluetooth Permission

**مراحل:**
1. کلیک روی "Bluetooth"
2. Allow/Don't Allow
3. بررسی وضعیت

---

### ✅ 10. Motion & Fitness Permission

**مراحل:**
1. کلیک روی "Motion & Fitness"
2. Allow/Don't Allow
3. بررسی وضعیت

---

### ✅ 11. Speech Recognition Permission

**مراحل:**
1. کلیک روی "Speech Recognition"
2. Allow/Don't Allow
3. بررسی وضعیت

---

### ✅ 12. Media Library Permission

**مراحل:**
1. کلیک روی "Media Library"
2. Allow/Don't Allow
3. بررسی وضعیت

---

### ✅ 13. Health Permission

**مراحل:**
1. کلیک روی "Health"
2. صفحه Health باز می‌شود
3. انتخاب داده‌های مجاز
4. بررسی وضعیت

**نکته:** Health فقط روی دستگاه واقعی کار می‌کند.

---

## تست Open Settings

### مراحل:
1. یک مجوز را رد کنید (مثلاً Camera)
2. دوباره کلیک روی همان مجوز
3. دیالوگ "Open Settings" نمایش داده می‌شود
4. کلیک "Open Settings"
5. Settings > [App Name] باز می‌شود
6. مجوز را فعال کنید
7. برگشت به برنامه
8. وضعیت به granted تغییر می‌کند

**نتیجه مورد انتظار:**
- ✅ Settings باز شود
- ✅ بعد از فعال کردن، وضعیت به‌روز شود

---

## تست Storage

### مراحل:
1. کلیک روی "Test Storage"
2. دیالوگ با نتایج نمایش داده می‌شود

**نتیجه مورد انتظار:**
```
String: Hello iOS!
Number: 42
Boolean: true
Map: {name: Flutter, version: 3.0, platform: iOS}
Key exists: true
```

---

## تست در Simulator

### iOS Simulator

```bash
# لیست simulatorها
xcrun simctl list devices

# اجرا
flutter run -d <simulator-id>
```

### ریست مجوزها

```bash
# ریست تمام مجوزها
xcrun simctl privacy booted reset all com.example.permissionMasterIosExample

# ریست مجوز خاص
xcrun simctl privacy booted reset camera com.example.permissionMasterIosExample
```

---

## تست در دستگاه واقعی

### پیش‌نیازها:
1. حساب Apple Developer
2. Certificate
3. Provisioning Profile
4. دستگاه متصل

### اجرا:
```bash
# لیست دستگاه‌ها
flutter devices

# اجرا
flutter run -d <device-id>
```

---

## بررسی Settings

### iOS Settings:
1. Settings > Privacy & Security
2. انتخاب نوع مجوز
3. پیدا کردن برنامه
4. بررسی وضعیت

---

## خطاهای رایج

### 1. "This app has crashed..."

**علت:** توضیحات مجوز در Info.plist نیست

**راه‌حل:**
```xml
<key>NSCameraUsageDescription</key>
<string>توضیحات</string>
```

### 2. مجوز درخواست نمی‌شود

**راه‌حل:**
- بررسی Info.plist
- Uninstall و reinstall برنامه
- ریست simulator

### 3. Health کار نمی‌کند

**علت:** Health فقط روی دستگاه واقعی کار می‌کند

**راه‌حل:** تست روی iPhone واقعی

---

## چک‌لیست نهایی

قبل از Release، این موارد را بررسی کنید:

- [ ] تمام 13 مجوز تست شده
- [ ] Allow و Deny برای هر مجوز تست شده
- [ ] Open Settings کار می‌کند
- [ ] Storage کار می‌کند
- [ ] تست در Simulator انجام شده
- [ ] تست در دستگاه واقعی انجام شده
- [ ] Info.plist کامل است
- [ ] توضیحات مجوزها واضح هستند
- [ ] هیچ Crash وجود ندارد
- [ ] UI/UX مناسب است

---

## گزارش نتایج

### فرمت گزارش:

```
تاریخ: [DATE]
دستگاه: [iPhone 14 Pro / Simulator]
iOS Version: [17.0]

✅ Camera: Passed
✅ Photos: Passed (Limited & Full)
✅ Microphone: Passed
✅ Location: Passed
✅ Contacts: Passed
✅ Calendar: Passed
✅ Reminders: Passed
✅ Notifications: Passed
✅ Bluetooth: Passed
✅ Motion: Passed
✅ Speech: Passed
✅ Music: Passed
❌ Health: Failed (Simulator only)

✅ Open Settings: Passed
✅ Storage: Passed

نتیجه: 12/13 Passed
```

---

## نکات مهم

1. **Health فقط روی دستگاه واقعی کار می‌کند**
2. **بعد از هر تغییر Info.plist، Clean و Rebuild کنید**
3. **برای تست مجدد، برنامه را Uninstall کنید**
4. **در Simulator می‌توانید مجوزها را ریست کنید**
5. **توضیحات مجوزها را با دقت بنویسید**

---

## پشتیبانی

اگر مشکلی پیدا کردید:
1. بررسی کنید Info.plist کامل است
2. لاگ‌ها را بررسی کنید
3. Issue در GitHub ایجاد کنید

**موفق باشید!** 🚀
