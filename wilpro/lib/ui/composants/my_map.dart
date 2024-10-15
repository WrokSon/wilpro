import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _HomePage();
}

class _HomePage extends State<MyMap> {
  late MapController _mapController;
  final _currentPosition = const LatLng(0, 0);

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, bottom: 30, right: 10, left: 10),
      height: 300,
      width: double.infinity,
      child: FlutterMap(
        options: const MapOptions(initialZoom: 13),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(markers: [
            Marker(
              point: _currentPosition,
              child: const Icon(Icons.location_on),
            )
          ]),
        ],
      ),
    );
  }
}
