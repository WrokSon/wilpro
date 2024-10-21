import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wilpro/model/structure/my_gps.dart';

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _HomePage();
}

class _HomePage extends State<MyMap> {
  late MapController _mapController;
  LatLng _currentPosition = const LatLng(48.866667, 2.333333);

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
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
      child: FutureBuilder(
          future: MyGps.instance.getCurrentLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _currentPosition = snapshot.data!;
              return FlutterMap(
                options: MapOptions(
                  initialZoom: 13,
                  initialCenter: _currentPosition,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(markers: [
                    Marker(
                      point: _currentPosition,
                      child: const Icon(Icons.location_on),
                    )
                  ]),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
