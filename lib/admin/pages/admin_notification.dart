import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';

class AdminNotification extends StatefulWidget {
  const AdminNotification({super.key});

  @override
  State<AdminNotification> createState() => _AdminNotificationState();
}

class _AdminNotificationState extends State<AdminNotification> {
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
    final filteredNotifications = _notifications.where((item) {
      return item["title"]!.toLowerCase().contains(_searchText.toLowerCase()) ||
          item["status"]!.toLowerCase().contains(_searchText.toLowerCase());
    }).toList();

    return Scaffold(
      body: Row(
        children: [
          const AppSidebar(currentRoute: '/adminNotification'), // ✅ Sidebar
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF14002E), Color(0xFF0A0018)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search by title or status",
                        hintStyle: const TextStyle(color: Colors.white54),
                        prefixIcon:
                        const Icon(Icons.search, color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white.withOpacity (0.1),
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
                            color: Colors.white.withOpacity(0.05),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(
                                item["title"]!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
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
            ),
          ),
        ],
      ),
    );
  }
}

