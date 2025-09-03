import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/incident_provider.dart';

class IncidentDetailPage extends StatelessWidget {
  final String incidentId;
  const IncidentDetailPage({super.key, required this.incidentId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<IncidentProvider>();
    final inc = provider.getById(incidentId);

    return Scaffold(
      appBar: AppBar(
        title: Text(inc.title),
        backgroundColor: const Color(0xFF12002D),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF14002E), Color(0xFF0A0018)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Location: ${inc.location}', style: const TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 6),
              Text('Reported by: ${inc.reporter}', style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 12),
              Text(inc.description, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 20),
              Row(
                children: [
                  _StatusBtn(label:'Pending', selected: inc.status=='Pending', onTap: ()=> context.read<IncidentProvider>().updateStatus(inc.id, 'Pending')),
                  const SizedBox(width: 8),
                  _StatusBtn(label:'In Progress', selected: inc.status=='In Progress', onTap: ()=> context.read<IncidentProvider>().updateStatus(inc.id, 'In Progress')),
                  const SizedBox(width: 8),
                  _StatusBtn(label:'Resolved', selected: inc.status=='Resolved', onTap: ()=> context.read<IncidentProvider>().updateStatus(inc.id, 'Resolved')),
                ],
              ),
            ],
          ),
        ),
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
