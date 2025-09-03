
import 'package:flutter/material.dart';
import 'app_theme.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> alerts = [
      {
        "title": "Cyclone expected",
        "subtitle": "Cyclone expected in 2 hours, move to shelter",
        "details":
            "A severe cyclone is expected to hit within 2 hours. Move to designated shelters and avoid traveling."
      },
      {
        "title": "Medical camp",
        "subtitle": "Medical camp available at Government School",
        "details":
            "Free first aid and basic treatment are available at the Government School today 9AM - 6PM."
      },
      {
        "title": "Flood alert",
        "subtitle": "Heavy rains expected, risk of flooding",
        "details":
            "Low-lying areas may be flooded due to continuous heavy rainfall. Prepare emergency supplies."
      },
    ];

    return Scaffold(
      appBar: AppTheme.gradientAppBar("Alerts"),
      body: AppTheme.gradientScaffoldBody(
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: alerts.length,
          itemBuilder: (context, i) {
            final a = alerts[i];
            return Card(
              color: Colors.white.withValues(alpha:0.08),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  child: Icon(Icons.warning, color: Colors.white),
                ),
                title: Text(a["title"]!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text(a["subtitle"]!, style: const TextStyle(color: Colors.white70)),
                trailing: const Icon(Icons.chevron_right, color: Colors.white),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(a["title"]!),
                      content: Text(a["details"]!),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
