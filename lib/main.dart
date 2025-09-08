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
import 'package:safe_zone/people/notifications_page.dart';
import 'package:safe_zone/people/people_home_page.dart';
import 'package:safe_zone/people/profile_page.dart';
import 'package:safe_zone/people/report_incident_page.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';
import 'login_page.dart';
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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final Telephony telephony = Telephony.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Request SMS permissions
  final bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
  if (permissionsGranted != true) {
    debugPrint("❌ SMS permissions not granted");
  }

  // Setup FCM
  await setupFCM();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IncidentProvider()),
      ],
      child: const DisasterApp(),
    ),
  );
}

// Firebase Cloud Messaging setup
Future<void> setupFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();

  String? token = await messaging.getToken();
  if (kDebugMode) print("FCM Token: $token");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) print("Foreground message: ${message.notification?.title}");
  });
}

// Send SMS
Future<void> sendSMS(String phone, String message) async {
  await telephony.sendSms(to: phone, message: message);
  print("📤 SMS sent to $phone: $message");
}

// Voice call
Future<void> callHelpline(String number) async {
  final Uri uri = Uri(scheme: 'tel', path: number);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch dialer';
  }
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
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Emergency Alert System',
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (_) => const RoleSelectionPage(),
        '/signup': (_) => const SignUpPage(),
        // People
        '/peopleDashboard': (_) => const PeopleHomePage(),
        '/report': (_) => const ReportIncidentPage(),
        '/reportIncident': (_) => const ReportIncidentPage(),
        '/profile': (_) => const ProfilePage(),
        '/alerts': (_) => const AlertsPage(),
        '/notifications': (_) => const NotificationsPage(),
        // Admin
        '/adminDashboard': (_) => const AdminDashboard(),
        '/incidentList': (_) => const IncidentListPage(),
        '/incidentMap': (_) => const IncidentMapPage(),
        '/adminAlert': (_) => const AdminAlert(),
        '/adminNotification': (_) => const AdminNotification(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/login') {
          final role = settings.arguments as String? ?? 'People';
          return MaterialPageRoute(builder: (_) => LoginPage(role: role));
        }
        if (settings.name == '/incidentDetail') {
          final incidentId = settings.arguments as String;
          return MaterialPageRoute(builder: (_) => IncidentDetailPage(incidentId: incidentId));
        }
        return null;
      },
    );
  }
}
