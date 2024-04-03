import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:store_redirect/store_redirect.dart';

void main() {
  const MethodChannel channel = MethodChannel('store_redirect');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'redirect':
          return;
        default:
          throw UnimplementedError();
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('redirect', () async {
    try {
      await StoreRedirect.redirect(
        androidAppId: "com.iyaffle.rangoli",
        iOSAppId: "585027354",
      );
    } catch (e) {
      fail("Exception encountered attempting redirect: $e");
    }
  });
}
