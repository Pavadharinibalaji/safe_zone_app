import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_zone/admin/pages/admin_dashboard.dart';
import 'package:safe_zone/admin/providers/incident_provider.dart';
import 'package:safe_zone/admin/pages/admin_alert.dart';
import 'package:safe_zone/admin/pages/incident_detail_page.dart';
import 'package:safe_zone/admin/pages/incident_list_page.dart';
import 'package:safe_zone/admin/pages/incident_map_page.dart';
import 'package:safe_zone/admin/pages/admin_notification.dart';
import 'package:safe_zone/people/alerts_page.dart';
import 'firebase_options.dart';
import 'login_page.dart';
import 'package:safe_zone/people/notifications_page.dart';
import 'package:safe_zone/people/people_home_page.dart';
import 'package:safe_zone/people/profile_page.dart';
import 'package:safe_zone/people/report_incident_page.dart';
import 'role_selection_page.dart';
import 'signup_page.dart';

// Background message handler must be a top-level function
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    print('Handling a background message: ${message.messageId}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set up FCM after Firebase initialization
  await setupFCM();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Fixed: Move MultiProvider setup to main() and call runApp only once
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IncidentProvider()),
      ],
      child: const DisasterApp(),
    ),
  );
}

// Move setupFCM outside of main() as a separate function
Future<void> setupFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permissions (for iOS/web)
  await messaging.requestPermission();

  // Get the device token
  String? token = await messaging.getToken();
  if (kDebugMode) {
    print("FCM Token: $token");
  }

  // Listen for foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print("Received a foreground message: ${message.notification?.title}");
    }
  });
}



class DisasterApp extends StatelessWidget {
  const DisasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme.dark(
        primary: Colors.deepPurpleAccent,
        secondary: Colors.purpleAccent,
      ),
      useMaterial3: true,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emergency Alert System',
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (_) => const RoleSelectionPage(),
        '/login': (_) => const LoginPage(),
        '/signup': (_) => const SignUpPage(),
        //People
        '/peopleDashboard': (_) => const PeopleHomePage(),
        '/report': (_) => const ReportIncidentPage(),
        '/reportIncident': (_) => const ReportIncidentPage(),
        '/profile': (_) => const ProfilePage(),
        '/alerts': (_) => const AlertsPage(),
        '/notifications': (_) => const NotificationsPage(),
        '/adminDashboard': (_) => const AdminDashboard(),
      },
    );
  }
}