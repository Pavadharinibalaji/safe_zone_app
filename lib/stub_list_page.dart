import 'package:flutter/material.dart';

class StubListPage extends StatelessWidget {
  final String title;
  const StubListPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(6, (i) => "$title item ${i + 1}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF6A1B9A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (_, i) => Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.purpleAccent, width: 1),
            ),
            child: Text(items[i], style: const TextStyle(color: Colors.white)),
          ),
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemCount: items.length,
        ),
      ),
    );
  }
}
