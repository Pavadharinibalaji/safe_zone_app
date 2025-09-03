
import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  final _locationController = TextEditingController();

  void _sendAlert() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("The alert was sent to users"),
        backgroundColor: Colors.green,
      ),
    );

    // Clear fields after sending
    _titleController.clear();
    _messageController.clear();
    _locationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const AppSidebar(currentRoute: '/alerts'),
          Expanded(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha:0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Broadcast Alerts",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _sendAlert,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Send Alert"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Title", style: TextStyle(color: Colors.white70)),
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.warning, color: Colors.white70),
                        hintText: "Enter alert title",
                        filled: true,
                        fillColor: Color(0x55222222),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    const Text("Message", style: TextStyle(color: Colors.white70)),
                    TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: "Enter alert message",
                        filled: true,
                        fillColor: Color(0x55222222),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    const Text("Area/Location", style: TextStyle(color: Colors.white70)),
                    TextField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        hintText: "Enter area or location",
                        filled: true,
                        fillColor: Color(0x55222222),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
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
