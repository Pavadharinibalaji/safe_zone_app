import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ReportIncidentPage extends StatefulWidget {
  const ReportIncidentPage({super.key});

  @override
  State<ReportIncidentPage> createState() => _ReportIncidentPageState();
}

class _ReportIncidentPageState extends State<ReportIncidentPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDisaster;

  File? _image;
  late final String? _description;
  String? _urgency;
  late final String? _city;
  late final String? _pincode;
  late final String? _address;
  bool _useCurrentLocation = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Success"), // Fixed: Added const
          content: const Text("Updated Successfully"), // Fixed: Added const
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"), // Fixed: Added const
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Report Incident")), // Fixed: Added const
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16), // Fixed: Added const
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedDisaster,
                decoration: const InputDecoration(labelText: "Select Disaster Type"), // Fixed: Added const
                items: ["Flood", "Cyclone", "Tsunami", "Earthquake", "Others"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDisaster = value;
                  });
                },
                validator: (value) => value == null ? "Please select a type" : null,
              ),
              if (_selectedDisaster == "Others")
                TextFormField(
                  decoration: const InputDecoration(labelText: "Enter Disaster Type"), // Fixed: Added const
                  onSaved: (value) {
                    // Store the custom disaster type - you can use this value in _submitForm()
                    // For now, we'll just store it locally or you can add it to your data model
                  },
                ),
              const SizedBox(height: 10), // Fixed: Added const
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image), // Fixed: Added const
                label: const Text("Upload Image"), // Fixed: Added const
              ),
              if (_image != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.file(_image!, height: 150),
                ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Description"), // Fixed: Added const
                maxLines: 3,
                onSaved: (value) => _description = value,
              ),
              DropdownButtonFormField<String>(
                value: _urgency,
                decoration: const InputDecoration(labelText: "Urgency"), // Fixed: Added const
                items: ["Low", "Medium", "High"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _urgency = value;
                  });
                },
                validator: (value) => value == null ? "Please select urgency" : null,
              ),
              CheckboxListTile(
                title: const Text("Use Current Location"), // Fixed: Added const
                value: _useCurrentLocation,
                onChanged: (val) {
                  setState(() {
                    _useCurrentLocation = val!;
                    if (_useCurrentLocation) {
                      _city = "Chennai";
                      _pincode = "600001";
                      _address = "Dummy Street, Chennai, India";
                    }
                  });
                },
              ),
              if (!_useCurrentLocation) ...[
                TextFormField(
                  decoration: const InputDecoration(labelText: "City"), // Fixed: Added const
                  onSaved: (value) => _city = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Pincode"), // Fixed: Added const
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _pincode = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Address"), // Fixed: Added const
                  onSaved: (value) => _address = value,
                ),
              ],
              const SizedBox(height: 20), // Fixed: Added const
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text("Submit"), // Fixed: Added const
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('_address', _address));
    properties.add(StringProperty('_description', _description));
    properties.add(StringProperty('_city', _city));
    properties.add(StringProperty('_pincode', _pincode));
  }
}