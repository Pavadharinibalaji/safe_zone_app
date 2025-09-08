// lib/services/communication.dart

import 'package:flutter/foundation.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';

final Telephony _telephony = Telephony.instance;

/// Sends an SMS to the specified [phone] number with the given [message].
Future<void> sendSMS(String phone, String message) async {
  try {
    await _telephony.sendSms(to: phone, message: message);
    if (kDebugMode) {
      print("📤 SMS sent to $phone: $message");
    }
  } catch (e) {
    if (kDebugMode) {
      print("❌ Failed to send SMS: $e");
    }
  }
}

/// Initiates a phone call to the specified [number].
Future<void> callHelpline(String number) async {
  final Uri uri = Uri(scheme: 'tel', path: number);
  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch dialer for $number';
    }
  } catch (e) {
    if (kDebugMode) {
      print("❌ Failed to make call: $e");
    }
  }
}


