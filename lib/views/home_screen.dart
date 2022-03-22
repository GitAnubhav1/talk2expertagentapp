import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:talk2expertagentapp/notificationservice/local_notification_service.dart';
import 'package:talk2expertagentapp/views/demo.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String deviceTokenToSendPushNotification = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          if (message.data['_id'] != null) {
            Navigator.of(context).push(
               MaterialPageRoute(
              builder: (context) => Demo(
                 id: message.data['_id'],
                 ),
               ),
             );
           }
        }
      },
    );
    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);

        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
  }

  Widget build(BuildContext context){
    getDeviceTokenToSendNotification();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Agent App"),
      ),
      body: const Center(
        child: Text("Push Notification"),
      ),
    );
  }
}