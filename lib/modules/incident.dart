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
}
