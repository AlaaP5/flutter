import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:plp/constants.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print(fCMToken);
    constantsValues.fcm = fCMToken.toString();
  }
}
