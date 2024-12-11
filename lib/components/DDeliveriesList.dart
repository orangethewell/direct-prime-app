import 'package:direct_prime_app/components/DButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:osrm/osrm.dart';
import 'dart:math' as math;

class DDeliveriesList extends StatefulWidget {
  const DDeliveriesList({super.key});

  @override
  _DDeliveriesListState createState() => _DDeliveriesListState();
}

class _DDeliveriesListState extends State<DDeliveriesList> {
  List<String> deliveries = [
    'Delivery 1',
    'Delivery 2',
    'Delivery 3',
    'Delivery 4',
    'Delivery 5',
    'Delivery 6',
    'Delivery 7',
    'Delivery 8',
    'Delivery 9',
    'Delivery 10',
    'Delivery 11',
  ];

  var from =
      const LatLng(-19.590003, -46.931219);
  var to =
      const LatLng(-19.605740, -46.940700);
  var points = <LatLng>[];
  @override
  void initState() {
    super.initState();
    getRoute();
  }

   /// [distance] the distance between two coordinates [from] and [to]
  num distance = 0.0;

  /// [duration] the duration between two coordinates [from] and [to]
  num duration = 0.0;

  /// [getRoute] get the route between two coordinates [from] and [to]
  Future<void> getRoute() async {
    final osrm = Osrm(
      source: OsrmSource(
        serverBuilder: OpenstreetmapServerBuilder().build,
      ),
    );
    final options = RouteRequest(
      coordinates: [
        (from.longitude, from.latitude),
        (to.longitude, to.latitude),
      ],
      overview: OsrmOverview.full,
    );
    final route = await osrm.route(options);
    distance = route.routes.first.distance!;
    duration = route.routes.first.duration!;
    points = route.routes.first.geometry!.lineString!.coordinates.map((e) {
      var location = e.toLocation();
      return LatLng(location.lat, location.lng);
    }).toList();

    setState(() {});
  }

  bool isPairly = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var delivery in deliveries)
          ListTile(
            title: Text(delivery),
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                ),
                context: context, 
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 200,
                        child: FlutterMap(
                          options: const MapOptions(
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

                            PolylineLayer(
                              polylines: [
                                Polyline(
                                  points: points,
                                  strokeWidth: 4.0,
                                  color: Colors.red,
                                ),
                              ],
                            ),

                            /// [MarkerLayer] draw the marker on the map
                            MarkerLayer(
                              markers: [
                                Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: from,
                                  child:const Icon(
                                    Icons.circle,
                                    color: Colors.blue,
                                  ),
                                ),
                                Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: to,
                                  child:  const Icon(
                                    Icons.circle,
                                    color: Colors.red,
                                  ),
                                ),

                                /// in the middle of [points] list we draw the [Marker] shows the distance between [from] and [to]
                                if (points.isNotEmpty)
                                  Marker(
                                    rotate: true,
                                    width: 80.0,
                                    height: 30.0,
                                    point: points[math.max(0, (points.length / 2).floor())],
                                    child:  Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${distance.toStringAsFixed(2)} m',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                        ]),
                      ),
                      Center(
                        child: Text(
                          delivery,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            const Text('Peso: 12kg'),
                            const SizedBox(height: 8),
                            const Text('Tamanho: 20x20cm'),
                            const SizedBox(height: 8),
                            const Text('Local de Captação: Senai Djalma Guimarães'),
                            const SizedBox(height: 8),
                            const Text('Local de Entrega: Supermercado ABC'),
                            const SizedBox(height: 16),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                  flex:1,
                                  child: DFullFilledButton(
                                    onClick: () {
                                      Navigator.pop(context);
                                    }, 
                                    child: Text("Aceitar")
                                  )
                                ),
                                Expanded(
                                  flex: 1,
                                  child: DFullBordedButton(
                                    onClick: () {
                                      Navigator.pop(context);
                                    }, 
                                    child: Text("Fechar")
                                  )
                                )
                              ]
                            )
    
                          ],
                        ),
                      )
                      
                    ],
                  );
              });
            },
          )
      ],
    );
  
  }
}