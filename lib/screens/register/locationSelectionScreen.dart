import 'package:direct_prime_app/components/DButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationSelectionPage extends StatefulWidget {
  final VoidCallback nextPageCallback;
  final double initialLatitude;
  final double initialLongitude;
  
  const LocationSelectionPage({
    super.key,
    required this.nextPageCallback,
    this.initialLatitude = 28.45306253513271,
    this.initialLongitude = 81.47338277012638,
  });

  @override
  State<LocationSelectionPage> createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  late LatLng _selectedLocation = LatLng(widget.initialLatitude, widget.initialLongitude);
  
  void getlocation() {
    double latitude = _selectedLocation.latitude;
    double longitude = _selectedLocation.longitude;
    var coordinates = [latitude, longitude];
    print(coordinates);
  }

  void setLocation(String roleName) {
    widget.nextPageCallback();
  }

  @override
  void initState() {
    super.initState();
    _selectedLocation =
        LatLng(widget.initialLatitude, widget.initialLongitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Text(
            "Selecione a região onde trabalha",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Isso vai nos ajudar a encontrar "
            "parceiros para trabalhar com você!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(height: 50),
        Text("Latitude: ${_selectedLocation.latitude}"),
        Text("Longitude: ${_selectedLocation.longitude}"),
        Flexible(
          flex: 10,
          child: FlutterMap(
            options: MapOptions(
              onTap: (tapLoc, position) {
                setState(() {
                  _selectedLocation = LatLng(position.latitude, position.longitude);
                });
              },
              interactionOptions: InteractionOptions(
                flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag
              ),
              initialCenter: const LatLng(-19.594934, -46.934390),
              initialZoom: 13.0,
            ), 
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.directprime.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: _selectedLocation,
                    child: const Icon(
                      Icons.location_on,
                      color: Color.fromARGB(255, 255, 7, 7),
                    )
                  )
                ],
              )
          ]),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DFullFilledButton(
              onClick: widget.nextPageCallback,
              child: Text("Confirmar"),
            ),
          ],
        )
        
      ],
    );
  }
}