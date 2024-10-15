import 'dart:async';
import 'package:flutter/services.dart';

class StoreRedirect {
  static const MethodChannel _channel = const MethodChannel('store_redirect');

  /// Note: It will not work with the iOS Simulator
  /// 
  /// [review] field set to true redirects users straight to App Store iOSAppId Reviews page
  static Future<void> redirect(
      {String? androidAppId, String? iOSAppId, bool review = false}) async {
    await _channel.invokeMethod('redirect',
        {'android_id': androidAppId, 'ios_id': iOSAppId, 'review': review});
    return null;
  }
}
