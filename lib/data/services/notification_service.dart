import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class WCNotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static bool _firebaseInitialized = false;

  /// Initialize Firebase once
  static Future<void> initFirebase() async {
    if (!_firebaseInitialized) {
      await Firebase.initializeApp();
      _firebaseInitialized = true;
    }
  }

  /// Request permission and get FCM token safely
  static Future<String?> getFcmToken() async {
    await initFirebase();

    // iOS: request notification permissions
    if (Platform.isIOS) {
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        print("User declined notification permissions");
        return null;
      }
    }

    // On iOS simulators, this will return null; that's expected
    final token = await _messaging.getToken();
    if (token == null && Platform.isIOS) {
      print(
          "[firebase_messaging] FCM token not available yet (probably iOS simulator)");
    }
    return token;
  }

  /// Get device info
  static Future<Map<String, String>> getDeviceInfo() async {
    await initFirebase();
    final deviceInfo = DeviceInfoPlugin();
    final installationId = await FirebaseInstallations.instance.getId();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return {
        'deviceId': installationId,
        'platform': 'android',
        'model': androidInfo.model,
        'osVersion': androidInfo.version.release,
      };
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return {
        'deviceId': installationId,
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

  /// Register device with backend
  static Future<void> registerDevice(String userID, String uToken) async {
    final token = await getFcmToken();
    if (token == null) {
      print("No FCM token available — skipping registration");
      return;
    }

    final deviceInfo = await getDeviceInfo();

    final body = {
      'token': token,
      'deviceId': deviceInfo['deviceId']!,
      'userId': userID,
      'platform': deviceInfo['platform']!,
    };

    try {
      final response = await http.post(
        Uri.parse(
            'https://backend.wencetechnologies.com/sportapp/api/Device/register'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $uToken',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print("Device registered successfully");
      } else {
        print(
            "Error registering device. Status: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (e) {
      print("Exception during device registration: $e");
    }
  }

  /// Listen for FCM token refreshes
  static void listenForTokenRefresh(String userID, String uToken) {
    _messaging.onTokenRefresh.listen((newToken) async {
      print("FCM token refreshed: $newToken");
      await registerDevice(userID, uToken);
    });
  }
}
