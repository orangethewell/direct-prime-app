import 'package:direct_prime_app/components/DButton.dart';
import 'package:direct_prime_app/components/DDeliveriesList.dart';
import 'package:direct_prime_app/components/DDrawerMenu.dart';
import 'package:direct_prime_app/components/DMapDeliveryIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:osrm/osrm.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
@override
class _HomeScreenState extends State<HomeScreen> {
  final _controller = DraggableScrollableController();
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
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(widget.title),
      ),
      drawer: const DDrawerMenu(),
      body: Builder(
        builder: (context) => FlutterMap(
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
                  height: 40.0,
                  alignment: Alignment.topCenter,
                  point: from, 
                  child: IconButton(
                    icon: DMapDeliveryIcon(icon: Icons.delivery_dining),
                    onPressed: () {
                      showBottomSheet(
                        enableDrag: true,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        ),
                        context: context, 
                        builder: (context) {
                          final theme = Theme.of(context);
                          // Using Wrap makes the bottom sheet height the height of the content.
                          // Otherwise, the height will be half the height of the screen.
                          return DecoratedBox(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: CustomScrollView(
                              controller: ScrollController(),
                              slivers: [
                                const SliverToBoxAdapter(
                                  child: Text('Title'),
                                ),
                                SliverList.list(
                                  children: const [
                                    Text('Content'),
                                  ],
                                ),
                              ],
                            ),
                          );
                      });
                    },
                  ),
                ),
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: to,
                  child: DMapDeliveryIcon(icon: Icons.delivery_dining),
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
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}