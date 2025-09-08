import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/sidebar.dart';
import '../providers/incident_provider.dart';
import 'package:safe_zone/services/communications.dart'; // ✅ Communication services

class IncidentListPage extends StatelessWidget {
  const IncidentListPage({super.key});

  Color _statusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orangeAccent;
      case 'In Progress':
        return Colors.amberAccent;
      case 'Resolved':
        return Colors.greenAccent;
      default:
        return Colors.purpleAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<IncidentProvider>();
    final incidents = provider.incidents;

    return Scaffold(
      body: Row(
        children: [
          const AppSidebar(currentRoute: '/incidentList'),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF14002E), Color(0xFF0A0018)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                itemCount: incidents.length,
                itemBuilder: (context, i) {
                  final inc = incidents[i];
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/incidentDetail',
                      arguments: inc.id,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0x6612002D),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title + Status
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                inc.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _statusColor(inc.status).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _statusColor(inc.status).withOpacity(0.6),
                                  ),
                                ),
                                child: Text(
                                  inc.status,
                                  style: TextStyle(color: _statusColor(inc.status)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(inc.description, style: const TextStyle(color: Colors.white70)),
                          const SizedBox(height: 8),
                          Text('Location: ${inc.location}', style: const TextStyle(color: Colors.white)),
                          Text('Reported by: ${inc.reporter}', style: const TextStyle(color: Colors.white70)),
                          const SizedBox(height: 12),
                          // Status buttons
                          Row(
                            children: [
                              _StatusBtn(
                                label: 'Pending',
                                selected: inc.status == 'Pending',
                                onTap: () => context.read<IncidentProvider>().updateStatus(inc.id, 'Pending'),
                              ),
                              const SizedBox(width: 8),
                              _StatusBtn(
                                label: 'In Progress',
                                selected: inc.status == 'In Progress',
                                onTap: () => context.read<IncidentProvider>().updateStatus(inc.id, 'In Progress'),
                              ),
                              const SizedBox(width: 8),
                              _StatusBtn(
                                label: 'Resolved',
                                selected: inc.status == 'Resolved',
                                onTap: () => context.read<IncidentProvider>().updateStatus(inc.id, 'Resolved'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBtn extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _StatusBtn({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF7B1FA2) : const Color(0x3312002D),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selected ? Colors.white38 : Colors.white12),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
