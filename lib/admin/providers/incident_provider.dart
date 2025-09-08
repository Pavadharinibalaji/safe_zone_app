// lib/admin/providers/incident_provider.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:safe_zone/admin/modules/incident.dart';
import 'package:safe_zone/services/communications.dart'; // ✅ Communication package

class IncidentProvider extends ChangeNotifier {
  final List<Incident> _incidents = [
    // Optional: initial demo incidents
  ];

  List<Incident> get incidents => List.unmodifiable(_incidents);
  Incident getById(String id) => _incidents.firstWhere((e) => e.id == id);

  final Telephony _telephony = Telephony.instance;

  IncidentProvider() {
    // ✅ Wrap SMS listener in try/catch to avoid initialization crashes
    _initializeSMSListener();
  }

  void _initializeSMSListener() async {
    try {
      final bool? permissionsGranted = await _telephony.requestPhoneAndSmsPermissions;
      if (permissionsGranted != true) {
        debugPrint("❌ SMS permissions not granted");
        return;
      }

      _telephony.listenIncomingSms(
        onNewMessage: (SmsMessage msg) {
          if (msg.body != null && msg.body!.startsWith("INCIDENT:")) {
            try {
              debugPrint("📩 SMS received: ${msg.body}");
              final parts = msg.body!.split(":");
              if (parts.length >= 3) {
                final title = parts[1];
                final location = parts[2];

                final incident = Incident(
                  id: "SMS-${DateTime.now().millisecondsSinceEpoch}",
                  title: title,
                  description: "Reported via SMS fallback",
                  location: location,
                  reporter: msg.address ?? "Unknown",
                  lat: 0.0,
                  lng: 0.0,
                  status: "Pending",
                  severity: "Medium",
                );

                _incidents.add(incident);
                notifyListeners();
                debugPrint("✅ Incident added from SMS: ${incident.title}");
              }
            } catch (e) {
              debugPrint("❌ Failed to parse SMS incident: $e");
            }
          }
        },
        listenInBackground: true,
      );
    } catch (e) {
      debugPrint("❌ Failed to start SMS listener: $e");
    }
  }

  /// Update status of an incident
  void updateStatus(String id, String newStatus) {
    final i = _incidents.indexWhere((e) => e.id == id);
    if (i == -1) return;
    _incidents[i].status = newStatus;
    notifyListeners();
  }

  /// 🚨 Add + Submit Incident
  Future<void> submitIncident(Incident incident) async {
    _incidents.add(incident);
    notifyListeners();

    try {
      // 1️⃣ Try sending to server
      await sendToServer(incident);
    } catch (_) {
      // 2️⃣ If no internet → SMS fallback
      await sendSMS(
        "+911234567890", // central helpline
        "INCIDENT:${incident.title}:${incident.location}",
      );

      // Optional: voice call fallback
      // await callHelpline("+911234567890");

      if (kDebugMode) {
        print("⚠️ Fallback SMS sent for incident: ${incident.title}");
      }
    }
  }

  /// Dummy server call (replace with real API)
  Future<void> sendToServer(Incident incident) async {
    if (incident.title.contains("Offline")) {
      throw Exception("No internet");
    }
    debugPrint("🌐 Sent to server: ${incident.title}");
  }
}
