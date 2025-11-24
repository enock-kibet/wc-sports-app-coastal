import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WCNotificationService {
  SharedPreferencesAsync get asyncPrefs => SharedPreferencesAsync();
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Get FCM token
  static Future<String?> getFcmToken() async {
    await _messaging.requestPermission(); // Ask for iOS permission
    return await _messaging.getToken();
  }

  // Get device info
  static Future<Map<String, String>> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    // Make sure Firebase is initialized
    await Firebase.initializeApp();

    // Firebase Installation ID (works for both Android & iOS)
    final installations = FirebaseInstallations.instance;
    final installationId = await installations.getId();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return {
        'deviceId': installationId, // ✅ use Firebase Installation ID
        'platform': 'android',
        'model': androidInfo.model,
        'osVersion': androidInfo.version.release,
      };
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return {
        'deviceId': installationId, // ✅ use Firebase Installation ID
        'platform': 'ios',
        'model': iosInfo.utsname.machine,
        'osVersion': iosInfo.systemVersion,
      };
    } else {
      return {
        'deviceId': installationId,
        'platform': Platform.operatingSystem,
      };
    }
  }

  // Register device with backend
  static Future<void> registerDevice(String userID, String uToken) async {
    final token = await getFcmToken();
    final deviceInfo = await getDeviceInfo();

    // print('`sstesst $uToken');

    if (token == null) {
      print("No FCM token available");
      return;
    }

    final body = {
      'token': token,
      'deviceId': deviceInfo['deviceId']!,
      'userId': userID,
      'platform': deviceInfo['platform']!,
    };

    final response = await http.post(
      Uri.parse(
          'https://backend.wencetechnologies.com/sportapp/api/Device/register'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $uToken'
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print("Device registered successfully");
    } else {
      print("Error registering device: ${body}");
    }
  }

  // Listen for token refreshes
  static void listenForTokenRefresh(String userID, String uToken) {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      print("FCM token refreshed: $newToken");
      await registerDevice(userID, uToken); // Re-register device
    });
  }
}
