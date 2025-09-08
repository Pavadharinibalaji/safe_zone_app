import 'package:flutter/material.dart';
import 'login_page.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF4B0F6B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Select Your Role',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                _roleButton(
                  context,
                  'People',
                  Icons.people,
                  Colors.blue,
                ),
                const SizedBox(height: 20),
                _roleButton(
                  context,
                  'Admin',
                  Icons.admin_panel_settings,
                  Colors.purple,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Enhanced role button with icon and color customization
Widget _roleButton(
    BuildContext context,
    String role,
    IconData icon,
    Color color,
    ) {
  return SizedBox(
    width: double.infinity,
    height: 60,
    child: ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/login',
          arguments: role, // Send role as String to match your onGenerateRoute
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
      ),
      icon: Icon(icon, size: 24),
      label: Text(
        role,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}