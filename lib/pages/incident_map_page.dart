import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../widgets/sidebar.dart';
import '../providers/incident_provider.dart';

class IncidentMapPage extends StatefulWidget {
  const IncidentMapPage({super.key});

  @override
  State<IncidentMapPage> createState() => _IncidentMapPageState();
}

class _IncidentMapPageState extends State<IncidentMapPage> {
  // Fixed: Changed from TabController to MapController
  final MapController _mapController = MapController();

  Color _sevColor(String s) {
    switch (s) {
      case 'Critical': return const Color(0xFFFF52B0);
      case 'High': return const Color(0xFFB388FF);
      case 'Medium': return const Color(0xFF8A2BE2);
      case 'Low': return const Color(0xFF7B1FA2);
      default: return Colors.purpleAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final incidents = context.watch<IncidentProvider>().incidents;

    return Scaffold(
      body: Row(
        children: [
          const AppSidebar(currentRoute: '/incident-map'),
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: const MapOptions(
                    initialCenter: LatLng(13.0674, 80.2376),
                    initialZoom: 11,
                    minZoom: 7,
                    maxZoom: 18,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png",
                      subdomains: const ['a','b','c','d'], // Fixed: Added const
                      userAgentPackageName: 'com.example.disaster_dashboard_final',
                    ),
                    MarkerLayer(
                      markers: [
                        for (final inc in incidents)
                          Marker(
                            point: LatLng(inc.lat, inc.lng),
                            width: 40,
                            height: 40,
                            child: Tooltip(
                              message: '${inc.title}\n${inc.location}',
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      // Fixed: Changed from withOpacity to withValues
                                        color: _sevColor(inc.severity).withValues(alpha: 0.45),
                                        blurRadius: 18,
                                        spreadRadius: 6
                                    ),
                                  ],
                                ),
                                child: Icon(
                                    Icons.location_on,
                                    color: _sevColor(inc.severity),
                                    size: 28
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                // Violet tint overlay to match your theme
                IgnorePointer(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x550A0018), Color(0x220A0018)],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        heroTag: 'zin',
                        mini: true,
                        onPressed: () {
                          final cam = _mapController.camera;
                          _mapController.move(cam.center, cam.zoom + 1);
                        },
                        child: const Icon(Icons.add),
                      ),
                      const SizedBox(height: 10),
                      FloatingActionButton(
                        heroTag: 'zout',
                        mini: true,
                        onPressed: () {
                          final cam = _mapController.camera;
                          _mapController.move(cam.center, cam.zoom - 1);
                        },
                        child: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}