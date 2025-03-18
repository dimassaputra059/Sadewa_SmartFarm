import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:frontend_app/presentation/pages/autentikasi/splash_screen.dart';

// 🔹 Inisialisasi Firebase Messaging
FirebaseMessaging messaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  String title = message.notification?.title ?? "";
  String body = message.notification?.body ?? "";

  if (title.isNotEmpty && body.isNotEmpty) {
    print("📩 Notifikasi diterima di background: $title - $body");
  } else {
    print("⚠️ Notifikasi kosong diabaikan.");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // 🔹 Setup Firebase Cloud Messaging
  await setupFirebaseMessaging();

  // 🔹 Setup Notifikasi Lokal
  setupLocalNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const SplashScreen(),
    );
  }
}

// ✅ Setup Firebase Messaging (Cegah Notifikasi Kosong)
Future<void> setupFirebaseMessaging() async {
  // 🔹 Minta izin notifikasi dari pengguna
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("✅ Izin notifikasi diberikan.");
  } else {
    print("❌ Izin notifikasi ditolak.");
    return;
  }

  // 🔹 Handle notifikasi saat aplikasi berjalan (Foreground)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String title = message.notification?.title ?? "";
    String body = message.notification?.body ?? "";

    if (title.isNotEmpty && body.isNotEmpty) {
      print("📩 Notifikasi diterima di foreground: $title - $body");
      showLocalNotification(title, body);
    } else {
      print("⚠️ Notifikasi kosong diabaikan.");
    }
  });

  // 🔹 Handle notifikasi saat aplikasi di background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

// ✅ Setup Lokal Notifikasi
void setupLocalNotifications() {
  var androidSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings = InitializationSettings(android: androidSettings);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // 🔹 Konfigurasi Channel Notifikasi untuk Android 13+
  var androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'General Notifications',
    description: 'Channel untuk notifikasi utama',
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidChannel);
}

// ✅ Tampilkan Popup Notifikasi di Foreground (Cegah Notifikasi Kosong)
void showLocalNotification(String title, String body) {
  if (title.isEmpty || body.isEmpty) {
    print("⚠️ Notifikasi lokal kosong diabaikan.");
    return;
  }

  var androidDetails = const AndroidNotificationDetails(
    'high_importance_channel',
    'General Notifications',
    importance: Importance.high,
    priority: Priority.high,
  );

  var notificationDetails = NotificationDetails(android: androidDetails);
  flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
}