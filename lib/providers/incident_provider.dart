import 'package:flutter/material.dart';
import '../modules/incident.dart';

class IncidentProvider extends ChangeNotifier {
  final List<Incident> _incidents = [
    Incident(id:'INC-001', title:'Urban Flooding', description:'Waterlogging reported in interior streets.', location:'Saidapet, Chennai', reporter:'Priya K', lat:13.0267, lng:80.2260, status:'In Progress', severity:'High'),
    Incident(id:'INC-002', title:'Fire near Market', description:'Firefighters on site; traffic diverted.', location:"Parry's Corner, Chennai", reporter:'John D', lat:13.0909, lng:80.2863, status:'Pending', severity:'Critical'),
    Incident(id:'INC-003', title:'Accident on OMR', description:'Multi-vehicle collision; ambulance dispatched.', location:'Sholinganallur, OMR', reporter:'Karthik', lat:12.8976, lng:80.2270, status:'In Progress', severity:'Medium'),
    Incident(id:'INC-004', title:'Power Outage', description:'Restoration work underway.', location:'Velachery, Chennai', reporter:'Shreya', lat:12.9790, lng:80.2180, status:'Resolved', severity:'Low'),
    Incident(id:'INC-005', title:'Coastal Wind Alert', description:'High winds reported; secure loose objects.', location:"Elliot's Beach", reporter:'Akash', lat:13.0006, lng:80.2707, status:'Pending', severity:'Medium'),
    Incident(id:'INC-006', title:'Tree Fall', description:'Tree blocking one lane; removal team notified.', location:'Adyar, Chennai', reporter:'Vivek', lat:13.0067, lng:80.2573, status:'Pending', severity:'Low'),
    Incident(id:'INC-007', title:'Gas Leak', description:'Suspected leak; area cordoned.', location:'T. Nagar, Chennai', reporter:'Anita', lat:13.0418, lng:80.2337, status:'In Progress', severity:'High'),
    Incident(id:'INC-008', title:'Building Crack', description:'Structural crack; inspection requested.', location:'Perambur, Chennai', reporter:'Ramesh', lat:13.1143, lng:80.2348, status:'Pending', severity:'Medium'),
    Incident(id:'INC-009', title:'Road Cave-in', description:'Small sinkhole; barricaded.', location:'Anna Salai, Chennai', reporter:'Sanjay', lat:13.0626, lng:80.2653, status:'In Progress', severity:'High'),
    Incident(id:'INC-010', title:'Flood Warning', description:'Water level rising near canal.', location:'Mylapore, Chennai', reporter:'Lakshmi', lat:13.0330, lng:80.2686, status:'Pending', severity:'High'),
  ];

  List<Incident> get incidents => List.unmodifiable(_incidents);
  Incident getById(String id) => _incidents.firstWhere((e) => e.id == id);

  void updateStatus(String id, String newStatus) {
    final i = _incidents.indexWhere((e) => e.id == id);
    if (i == -1) return;
    _incidents[i].status = newStatus;
    notifyListeners();
  }
}
