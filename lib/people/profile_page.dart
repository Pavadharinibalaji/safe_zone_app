
import 'package:flutter/material.dart';
import 'app_theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = true;

  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController(text: "John Doe");
  final email = TextEditingController(text: "john@example.com");
  final phone = TextEditingController(text: "+91 9876543210");
  final age = TextEditingController(text: "28");
  final password = TextEditingController(text: "password123");

  final blood = TextEditingController(text: "O+");
  final conditions = TextEditingController(text: "Asthma");
  final emergencyName = TextEditingController(text: "Jane Doe");
  final emergencyPhone = TextEditingController(text: "+91 9876500000");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.gradientAppBar(
        "Profile",
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => setState(() => isEditing = !isEditing),
            tooltip: isEditing ? "Disable Editing" : "Edit Profile",
          )
        ],
      ),
      body: AppTheme.gradientScaffoldBody(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 42,
                      backgroundColor: Colors.white24,
                      child: const Icon(Icons.person, size: 48, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const _SectionHeader("Basic Info"),
                  _tf("Name", name),
                  _tf("Email", email, keyboardType: TextInputType.emailAddress),
                  _tf("Phone Number", phone, keyboardType: TextInputType.phone),
                  _tf("Age", age, keyboardType: TextInputType.number),
                  _tf("Password", password, obscure: true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: isEditing ? () {} : null,
                      child: const Text("Change Password"),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const _SectionHeader("Emergency Info"),
                  _tf("Blood Group", blood),
                  _tf("Medical Conditions", conditions, maxLines: 2),
                  Row(
                    children: [
                      Expanded(child: _tf("Emergency Contact Name", emergencyName)),
                      const SizedBox(width: 8),
                      Expanded(child: _tf("Emergency Contact Number", emergencyPhone, keyboardType: TextInputType.phone)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: isEditing ? () {
                        if (_formKey.currentState?.validate() ?? false) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile updated")));
                        }
                      } : null,
                      child: const Text("Update Profile"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tf(String label, TextEditingController c,
      {bool obscure = false, int maxLines = 1, TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: c,
        enabled: isEditing,
        obscureText: obscure,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        validator: (v) => (v == null || v.trim().isEmpty) ? "Required" : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withValues(alpha:0.08),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.white.withValues(alpha:0.2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.white.withValues(alpha:0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.deepPurpleAccent),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 12),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
