import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _notifications = [
    {"title": "Flood Alert - Chennai", "status": "Active"},
    {"title": "Earthquake Tremors - Delhi", "status": "Pending"},
    {"title": "Cyclone Warning - Mumbai", "status": "Active"},
    {"title": "Fire Accident - Market Area", "status": "Resolved"},
    {"title": "Landslide Risk - Kerala Hills", "status": "Pending"},
  ];

  String _searchText = "";

  @override
  Widget build(BuildContext context) {
    final filteredNotifications = _notifications.where((notification) {
      final title = notification["title"]!.toLowerCase();
      final status = notification["status"]!.toLowerCase();
      final query = _searchText.toLowerCase();
      return title.contains(query) || status.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF1A0B2E),
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search by title or status",
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: Colors.white.withValues(alpha:0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "NOTIFICATIONS",
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredNotifications.length,
                itemBuilder: (context, index) {
                  final item = filteredNotifications[index];
                  return Card(
                    color: Colors.white.withValues(alpha:0.05),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        item["title"]!,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        item["status"]!,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
