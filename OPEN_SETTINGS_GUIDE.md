# راهنمای استفاده از Open App Settings

این راهنما نحوه استفاده از قابلیت `openAppSettings` را برای هدایت کاربر به تنظیمات iOS توضیح می‌دهد.

## چرا Open Settings مهم است؟

در iOS، زمانی که کاربر یک مجوز را رد می‌کند، تنها راه فعال کردن آن، رفتن به Settings > [App Name] و فعال کردن دستی مجوز است. این متد به شما کمک می‌کند کاربر را مستقیماً به صفحه تنظیمات برنامه هدایت کنید.

## استفاده ساده

```dart
import 'package:permission_master_ios/permission_master_ios.dart';

Future<void> openSettings() async {
  final plugin = PermissionMasterIos();
  
  final opened = await plugin.openAppSettings();
  
  if (opened) {
    print('✅ Settings opened successfully');
  } else {
    print('❌ Failed to open settings');
  }
}
```

## الگوی کامل: Request → Denied → Open Settings

### مثال 1: Camera Permission

```dart
Future<void> requestCameraWithFallback(BuildContext context) async {
  final plugin = PermissionMasterIos();
  
  // درخواست مجوز
  final status = await plugin.requestCameraPermission();
  
  if (status == PermissionStatus.granted) {
    // مجوز داده شد - استفاده از دوربین
    print('✅ Camera permission granted');
    _openCamera();
  } else if (status == PermissionStatus.denied) {
    // مجوز رد شد - نمایش دیالوگ
    _showSettingsDialog(context, plugin);
  } else if (status == PermissionStatus.restricted) {
    // محدودیت سیستمی
    _showRestrictedDialog(context);
  }
}

void _showSettingsDialog(BuildContext context, PermissionMasterIos plugin) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Camera Permission Required'),
      content: const Text(
        'Camera access is required to take photos. '
        'Please enable it in Settings.',
      ),
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

### مثال 2: با SnackBar

```dart
Future<void> requestPermissionWithSnackBar(BuildContext context) async {
  final plugin = PermissionMasterIos();
  
  final status = await plugin.requestMicrophonePermission();
  
  if (status == PermissionStatus.granted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Microphone permission granted'),
        backgroundColor: Colors.green,
      ),
    );
  } else if (status == PermissionStatus.denied) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('❌ Microphone permission denied'),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Settings',
          textColor: Colors.white,
          onPressed: () async {
            await plugin.openAppSettings();
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
```

### مثال 3: با Bottom Sheet

```dart
Future<void> requestPermissionWithBottomSheet(BuildContext context) async {
  final plugin = PermissionMasterIos();
  
  final status = await plugin.requestPhotosPermission();
  
  if (status == PermissionStatus.denied) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.photo_library,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'Photos Access Required',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please enable photo library access in Settings to select photos.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await plugin.openAppSettings();
                    },
                    child: const Text('Open Settings'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## الگوی پیشرفته: Check → Request → Settings

```dart
class PermissionHandler {
  final PermissionMasterIos _plugin = PermissionMasterIos();
  
  Future<bool> ensureCameraPermission(BuildContext context) async {
    // 1. بررسی وضعیت فعلی
    final currentStatus = await _plugin.checkPermissionStatus(
      PermissionType.camera,
    );
    
    // اگر قبلاً داده شده، مستقیماً برگردان
    if (currentStatus == PermissionStatus.granted) {
      return true;
    }
    
    // 2. اگر قبلاً رد شده، مستقیماً به Settings برو
    if (currentStatus == PermissionStatus.denied) {
      return await _showSettingsPrompt(context, 'Camera');
    }
    
    // 3. اگر هنوز درخواست نشده، درخواست کن
    if (currentStatus == PermissionStatus.notDetermined) {
      final status = await _plugin.requestCameraPermission();
      
      if (status == PermissionStatus.granted) {
        return true;
      } else if (status == PermissionStatus.denied) {
        return await _showSettingsPrompt(context, 'Camera');
      }
    }
    
    return false;
  }
  
  Future<bool> _showSettingsPrompt(
    BuildContext context,
    String permissionName,
  ) async {
    final shouldOpen = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$permissionName Permission Required'),
        content: Text(
          '$permissionName access is currently disabled. '
          'Would you like to open Settings to enable it?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Not Now'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
    
    if (shouldOpen == true) {
      await _plugin.openAppSettings();
      return false; // User needs to manually enable and return
    }
    
    return false;
  }
}

// استفاده
final handler = PermissionHandler();
final hasPermission = await handler.ensureCameraPermission(context);

if (hasPermission) {
  // استفاده از دوربین
  _openCamera();
} else {
  print('Permission not granted');
}
```

## مثال با State Management

```dart
class PermissionManager extends ChangeNotifier {
  final PermissionMasterIos _plugin = PermissionMasterIos();
  
  Map<String, PermissionStatus> _statuses = {};
  
  PermissionStatus? getStatus(String permission) => _statuses[permission];
  
  Future<void> requestPermission(
    String name,
    Future<PermissionStatus> Function() request,
  ) async {
    final status = await request();
    _statuses[name] = status;
    notifyListeners();
  }
  
  Future<void> openSettings() async {
    await _plugin.openAppSettings();
  }
}

// در Widget
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PermissionManager>(
      builder: (context, manager, child) {
        final cameraStatus = manager.getStatus('camera');
        
        return Column(
          children: [
            Text('Camera: ${cameraStatus?.name ?? "Unknown"}'),
            if (cameraStatus == PermissionStatus.denied)
              ElevatedButton(
                onPressed: () => manager.openSettings(),
                child: const Text('Open Settings'),
              ),
          ],
        );
      },
    );
  }
}
```

## نکات مهم

### 1. زمان‌بندی مناسب

```dart
// ❌ بد: بلافاصله بعد از رد شدن
final status = await plugin.requestCameraPermission();
if (status == PermissionStatus.denied) {
  await plugin.openAppSettings(); // خیلی سریع!
}

// ✅ خوب: با تأیید کاربر
final status = await plugin.requestCameraPermission();
if (status == PermissionStatus.denied) {
  final shouldOpen = await _askUser();
  if (shouldOpen) {
    await plugin.openAppSettings();
  }
}
```

### 2. توضیح واضح

```dart
// ✅ توضیح دهید چرا نیاز است
AlertDialog(
  title: const Text('Camera Access Required'),
  content: const Text(
    'We need camera access to:\n'
    '• Take profile photos\n'
    '• Scan QR codes\n'
    '• Record videos\n\n'
    'Please enable it in Settings.',
  ),
  // ...
)
```

### 3. بررسی بازگشت از Settings

```dart
class _MyWidgetState extends State<MyWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // کاربر از Settings برگشته - بررسی مجدد
      _recheckPermissions();
    }
  }
  
  Future<void> _recheckPermissions() async {
    final plugin = PermissionMasterIos();
    final status = await plugin.checkPermissionStatus(PermissionType.camera);
    
    if (status == PermissionStatus.granted) {
      print('✅ Permission enabled in Settings!');
      // ادامه عملیات
    }
  }
}
```

## مثال کامل با Lifecycle

```dart
import 'package:flutter/material.dart';
import 'package:permission_master_ios/permission_master_ios.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  final _plugin = PermissionMasterIos();
  PermissionStatus? _cameraStatus;
  bool _waitingForSettings = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _waitingForSettings) {
      _waitingForSettings = false;
      _checkPermission();
    }
  }

  Future<void> _checkPermission() async {
    final status = await _plugin.checkPermissionStatus(PermissionType.camera);
    setState(() => _cameraStatus = status);
  }

  Future<void> _requestPermission() async {
    final status = await _plugin.requestCameraPermission();
    setState(() => _cameraStatus = status);

    if (status == PermissionStatus.granted) {
      _openCamera();
    } else if (status == PermissionStatus.denied) {
      _showSettingsDialog();
    }
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Camera Permission Required'),
        content: const Text(
          'Camera access is required to take photos. '
          'Please enable it in Settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              _waitingForSettings = true;
              await _plugin.openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _openCamera() {
    print('📷 Opening camera...');
    // TODO: Implement camera
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt,
              size: 100,
              color: _cameraStatus == PermissionStatus.granted
                  ? Colors.green
                  : Colors.grey,
            ),
            const SizedBox(height: 24),
            Text(
              'Status: ${_cameraStatus?.name ?? "Unknown"}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            if (_cameraStatus != PermissionStatus.granted)
              ElevatedButton(
                onPressed: _requestPermission,
                child: const Text('Request Camera Permission'),
              ),
            if (_cameraStatus == PermissionStatus.granted)
              ElevatedButton(
                onPressed: _openCamera,
                child: const Text('Open Camera'),
              ),
          ],
        ),
      ),
    );
  }
}
```

## خلاصه

✅ همیشه قبل از باز کردن Settings، از کاربر تأیید بگیرید  
✅ توضیح دهید چرا به مجوز نیاز دارید  
✅ از WidgetsBindingObserver برای تشخیص بازگشت از Settings استفاده کنید  
✅ وضعیت را بعد از بازگشت مجدداً بررسی کنید  
✅ UI/UX واضح و کاربرپسند داشته باشید  

برای مثال‌های بیشتر، [EXAMPLES.md](EXAMPLES.md) را مطالعه کنید.
