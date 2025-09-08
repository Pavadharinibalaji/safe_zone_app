class Incident {
  final String id;
  final String title;
  final String description;
  final String location;
  final String reporter;
  final double lat;
  final double lng;
  String status;
  final String severity;

  Incident({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.reporter,
    required this.lat,
    required this.lng,
    this.status = 'Pending',
    this.severity = 'Medium',
  });

  factory Incident.fromJson(Map<String, dynamic> json) => Incident(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    location: json['location'],
    reporter: json['reporter'],
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
    status: json['status'],
    severity: json['severity'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'location': location,
    'reporter': reporter,
    'lat': lat,
    'lng': lng,
    'status': status,
    'severity': severity,
  };
}
