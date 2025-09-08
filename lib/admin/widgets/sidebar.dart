import 'package:flutter/material.dart';

class AppSidebar extends StatefulWidget {
  final String currentRoute;
  const AppSidebar({super.key, required this.currentRoute});

  @override
  State<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    final width = expanded ? 220.0 : 72.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF14002E), Color(0xFF0A0018)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  expanded ? Icons.chevron_left : Icons.chevron_right,
                  color: Colors.purpleAccent,
                ),
                onPressed: () => setState(() => expanded = !expanded),
              ),
            ),
            _item(context, '/adminDashboard', Icons.home, 'Home'),
            _item(context, '/incidents', Icons.list_alt, 'Incidents'),
            _item(context, '/incidentMap', Icons.location_on, 'Incident Map'),
            _item(context, '/adminAlert', Icons.warning_amber_rounded, 'Alerts'),
            _item(context, '/adminNotification', Icons.notifications, 'Notifications'),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _item(BuildContext context, String route, IconData icon, String label) {
    final sel = widget.currentRoute == route;

    return InkWell(
      onTap: () {
        if (ModalRoute.of(context)?.settings.name == route) return;
        Navigator.pushNamedAndRemoveUntil(context, route, (_) => false);
      },
      child: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: sel ? const Color(0x3312002D) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(
              icon,
              color: sel ? Colors.white : Colors.purpleAccent,
              size: 22,
            ),
            if (expanded) ...[
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: sel ? Colors.white : Colors.white70,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
