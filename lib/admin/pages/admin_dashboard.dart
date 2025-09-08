import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const AppSidebar(currentRoute: '/adminDashboard'),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/home_bg.png'),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                Container(color: const Color(0x440A0018)),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: const [
                        _FeatureCard(
                          icon: Icons.list_alt,
                          title: 'Incidents',
                          route: '/incidentList',
                        ),
                        _FeatureCard(
                          icon: Icons.location_on,
                          title: 'Incident Map',
                          route: '/incidentMap',
                        ),
                        _FeatureCard(
                          icon: Icons.warning_amber_rounded,
                          title: 'Alerts',
                          route: '/adminAlert',
                        ),
                        _FeatureCard(
                          icon: Icons.notifications,
                          title: 'Notifications',
                          route: '/adminNotification',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        width: 220,
        height: 120,
        decoration: BoxDecoration(
          color: const Color(0x6612002D),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.purpleAccent, size: 34),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
