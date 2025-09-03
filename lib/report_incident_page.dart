
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Report Incident page – mobile + web friendly (no dart:io import needed)
class ReportIncidentPage extends StatefulWidget {
  static const String routeName = '/reportIncident';

  const ReportIncidentPage({super.key});

  @override
  State<ReportIncidentPage> createState() => _ReportIncidentPageState();
}

class _ReportIncidentPageState extends State<ReportIncidentPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _locationCtrl = TextEditingController(text: "Chennai, India");
  bool _useCurrentLocation = true;

  final _picker = ImagePicker();
  XFile? _pickedImage;
  Uint8List? _pickedImageBytes; // works on web + mobile

  DateTime get _now => DateTime.now();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final img = await _picker.pickImage(source: ImageSource.gallery);
    if (img == null) return;
    // Read bytes on ALL platforms => avoids dart:io
    final bytes = await img.readAsBytes();
    setState(() {
      _pickedImage = img;
      _pickedImageBytes = bytes;
    });
  }

  void _toggleCurrentLocation(bool value) {
    setState(() {
      _useCurrentLocation = value;
      if (value) {
        _locationCtrl.text = "Chennai, India";
      } else {
        _locationCtrl.clear();
      }
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.greenAccent, size: 64),
            const SizedBox(height: 12),
            const Text("Updated Successfully",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(
              "Submitted on ${_now.toLocal()}",
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("OK", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final violetBlack = const LinearGradient(
      colors: [Color(0xFF0A0A0A), Color(0xFF6A1B9A)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF9C27B0)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Incident"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: violetBlack),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _titleCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Title",
                      labelStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: border,
                      focusedBorder: border.copyWith(
                        borderSide: const BorderSide(color: Color(0xFFE1BEE7), width: 2),
                      ),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? "Please enter a title"
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descCtrl,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Description",
                      labelStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: border,
                      focusedBorder: border.copyWith(
                        borderSide: const BorderSide(color: Color(0xFFE1BEE7), width: 2),
                      ),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? "Please enter description"
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Switch(
                        value: _useCurrentLocation,
                        activeColor: const Color(0xFFE1BEE7),
                        onChanged: _toggleCurrentLocation,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          "Use Current Location",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _locationCtrl,
                    enabled: !_useCurrentLocation,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Location",
                      hintText: "City, Area (auto-filled if using current location)",
                      labelStyle: const TextStyle(color: Colors.white70),
                      hintStyle: const TextStyle(color: Colors.white38),
                      enabledBorder: border,
                      focusedBorder: border.copyWith(
                        borderSide: const BorderSide(color: Color(0xFFE1BEE7), width: 2),
                      ),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? "Please provide a location"
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.image),
                        label: const Text("Upload Photo"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: const Color(0xFFE1BEE7),
                          side: const BorderSide(color: Color(0xFF9C27B0)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _pickedImage == null ? "No image selected" : (_pickedImage!.name),
                          style: const TextStyle(color: Colors.white70),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (_pickedImageBytes != null) ...[
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF9C27B0)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Image.memory(
                        _pickedImageBytes!,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Text(
                    "Auto Date & Time: ${_now.toLocal()}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6A1B9A),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
}
