
import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'report_incident_page.dart';
import 'alerts_page.dart';
import 'notifications_page.dart';
import 'profile_page.dart';

class PeopleHomePage extends StatelessWidget {
  const PeopleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.gradientAppBar('Home'),
      drawer: _buildDrawer(context),
      body: AppTheme.gradientScaffoldBody(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Emergency\nAlert System',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Do you want to send an SOS alert?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
                            FilledButton(
                              onPressed: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('SOS Sent! Nearby rescuers will receive your signal.')),
                                );
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('SOS', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: _homeCard(context, Icons.report, 'Report Incident', () {
                        Navigator.pushNamed(context, ReportIncidentPage.routeName);
                      })),
                      const SizedBox(width: 12),
                      Expanded(child: _homeCard(context, Icons.warning_amber, 'Alerts', () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const AlertsPage()));
                      })),
                      const SizedBox(width: 12),
                      Expanded(child: _homeCard(context, Icons.notifications, 'Notifications', () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsPage()));
                      })),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _homeCard(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha:0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.purpleAccent.withValues(alpha:0.5)),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.purpleAccent, size: 32),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: AppTheme.gradientBg(),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              _drawerItem(context, Icons.person, 'Profile', const ProfilePage()),
              _drawerItem(context, Icons.report, 'Report Incident', null, routeName: ReportIncidentPage.routeName),
              _drawerItem(context, Icons.warning_amber_rounded, 'Alerts', const AlertsPage()),
              _drawerItem(context, Icons.notifications, 'Notifications', const NotificationsPage()),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _drawerItem(BuildContext context, IconData icon, String title, Widget? page, {String? routeName}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context);
        if (routeName != null) {
          Navigator.pushNamed(context, routeName);
        } else if (page != null) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        }
      },
    );
  }
}
