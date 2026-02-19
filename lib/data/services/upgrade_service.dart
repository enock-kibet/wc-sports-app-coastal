import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:in_app_update/in_app_update.dart';

class AndroidInAppUpdates {
  static Future<void> checkAndUpdate({
    bool immediate = false,
  }) async {
    if (!Platform.isAndroid) return;

    try {
      final info = await InAppUpdate.checkForUpdate();

      if (kDebugMode) {
        debugPrint('UpdateAvailability: ${info.updateAvailability}');
        debugPrint('ImmediateAllowed: ${info.immediateUpdateAllowed}');
        debugPrint('FlexibleAllowed: ${info.flexibleUpdateAllowed}');
        debugPrint('AvailableVersionCode: ${info.availableVersionCode}');
      }

      // Update is available?
      final available =
          info.updateAvailability == UpdateAvailability.updateAvailable;

      if (!available) return;

      if (immediate && info.immediateUpdateAllowed) {
        // “Force update” style (best for critical)
        await InAppUpdate.performImmediateUpdate();
        return;
      }

      if (info.flexibleUpdateAllowed) {
        // Optional update style
        await InAppUpdate.startFlexibleUpdate();
        await InAppUpdate.completeFlexibleUpdate();
      }
    } catch (e) {
      debugPrint('In-app update failed: $e');
    }
  }
}
