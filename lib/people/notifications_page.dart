
import 'package:flutter/material.dart';
import 'app_theme.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts = [
      {"icon": Icons.warning, "color": Colors.red, "text": "Heavy rain expected tonight. Stay indoors.", "time": "2h ago"},
      {"icon": Icons.health_and_safety, "color": Colors.blue, "text": "Free medical camp at Community Hall tomorrow.", "time": "5h ago"},
    ];

    final reportStatuses = [
      {"icon": Icons.hourglass_empty, "color": Colors.purple, "text": "Your report is Pending.", "time": "Yesterday"},
      {"icon": Icons.sync, "color": Colors.orange, "text": "Your report is In Progress.", "time": "2 days ago"},
      {"icon": Icons.check_circle, "color": Colors.green, "text": "Your report has been Resolved.", "time": "3 days ago"},
      {"icon": Icons.visibility, "color": Colors.teal, "text": "Your report was seen by authorities. You will be notified soon.", "time": "Just now"},
    ];

    return Scaffold(
      appBar: AppTheme.gradientAppBar("Notifications"),
      body: AppTheme.gradientScaffoldBody(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text("Alerts", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...alerts.map((n) => _tile(n)),
            const SizedBox(height: 20),
            const Text("Report Status", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...reportStatuses.map((n) => _tile(n)),
          ],
        ),
      ),
    );
  }

  Widget _tile(Map n) {
    return Card(
      color: Colors.white.withValues(alpha:0.1),
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: (n["color"] as Color).withValues(alpha:0.2),
          child: Icon(n["icon"] as IconData, color: n["color"] as Color),
        ),
        title: Text(n["text"].toString(), style: const TextStyle(color: Colors.white)),
        subtitle: Text(n["time"].toString(), style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ),
    );
  }
}
