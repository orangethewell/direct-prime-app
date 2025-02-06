import 'package:direct_prime_app/components/DButton.dart';
import 'package:direct_prime_app/components/DDrawerMenu.dart';
import 'package:direct_prime_app/components/DMapDeliveryIcon.dart';
import 'package:direct_prime_app/deliveryData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:osrm/osrm.dart';
import 'package:geolocator/geolocator.dart';

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
  var deliveries = getNextToUserDeliveries();
  late MapController mapController;
  LatLong2 _currentPosition = LatLong2(0, 0);
  var jobSelected = -1;
  List<LatLng> points = [];
  DraggableScrollableController _draggableScrollableController = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    _getCurrentLocation();
    // _getPositionStream();
  }

  Future<void> _getCurrentLocation() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied && await Geolocator.isLocationServiceEnabled()) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }
    var position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLong2(position.latitude, position.longitude);
    });
    mapController.move(LatLng(position.latitude, position.longitude), 12.0);
  }

  void _getPositionStream() {
    Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        distanceFilter: 10
      ),
    ).listen((Position position) {
      setState(() {
        _currentPosition = LatLong2(position.latitude, position.longitude);
      });
    });
  }

   /// [distance] the distance between two coordinates [from] and [to]
  num distance = 0.0;

  /// [duration] the duration between two coordinates [from] and [to]
  num duration = 0.0;

  /// [getRoute] get the route between two coordinates [from] and [to]
  Future<void> getRoute(LatLong2 from, LatLong2 to) async {
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
        builder: (context) => Stack(
          children: [
            FlutterMap(
              mapController: mapController,
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

                PolylineLayer(polylines: [
                  if (points.isNotEmpty)
                    Polyline(
                      points: points,
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                ]),

                /// [MarkerLayer] draw the marker on the map
                MarkerLayer(
                  markers: [
                    if (_currentPosition.latitude != 0 && _currentPosition.longitude != 0)
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        alignment: Alignment.bottomCenter,
                        point: LatLng(_currentPosition.latitude, _currentPosition.longitude),
                        child: const Icon(Icons.arrow_circle_down, size: 40, color: Colors.blue),
                      ),

                    for (var delivery in deliveries)
                      Marker(
                        width: 20.0,
                        height: 20.0,
                        point: LatLng(delivery.senderGeocode.latitude, delivery.senderGeocode.longitude),
                        child: Icon(Icons.circle, size: 20, color: Colors.blue[300]),
                      ),
                    

                    if (jobSelected != -1) 
                      Marker(
                        point: LatLng(deliveries[jobSelected].receiverGeocode.latitude, deliveries[jobSelected].receiverGeocode.longitude), 
                        child: DMapDeliveryIcon(icon: Icons.send_and_archive_outlined,)
                      ),

                    for (var delivery in deliveries) 
                      if (jobSelected == -1 || deliveries.indexOf(delivery) == jobSelected)
                      Marker(
                        width: 80.0,
                        height: 40.0,
                        alignment: Alignment.topCenter,
                        point: LatLng(delivery.senderGeocode.latitude, delivery.senderGeocode.longitude),
                        child: IconButton(
                          icon: DMapDeliveryIcon(icon: Icons.delivery_dining),
                          onPressed: () async{
                            await getRoute(delivery.senderGeocode, delivery.receiverGeocode);
                            setState(() {
                              jobSelected = deliveries.indexOf(delivery);
                            });
                            _draggableScrollableController.animateTo(
                              0.6,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ), 
                  ],
                ),
            ]),
             DraggableScrollableSheet(
              controller: _draggableScrollableController,
              initialChildSize: 0.2, // Tamanho inicial
              minChildSize: 0.2, // Tamanho mínimo
              maxChildSize: 0.6, // Tamanho máximo
              snap: true,
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                  ),
                  child: jobSelected == -1 ? ListView(
                    controller: scrollController,
                    children: [
                      Center(child: Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)))),
                      SizedBox(height: 20),
                      Text(
                        'Selecione um ponto para ter mais informações', 
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ) : ListView (
                    controller: scrollController,
                    children: [
                      Center(child: Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)))),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          BackButton(
                            onPressed: () {
                              setState(() {
                                jobSelected = -1;
                                points = [];
                              });
                              _draggableScrollableController.animateTo(
                                0.2,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                          const Text('Detalhes da entrega', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,  
                          children: [
                            Image(image: NetworkImage(deliveries[jobSelected].productImage), width: 100, height: 100, fit: BoxFit.cover),
                            SizedBox(width: 10),
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                    text: 'Remetente: ',
                                    style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                      text: deliveries[jobSelected].sendingCompanyName,
                                      style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                    text: 'Destino: ',
                                    style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                      text: deliveries[jobSelected].receivingCompanyName,
                                      style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                    text: 'Produto: ',
                                    style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                      text: deliveries[jobSelected].productName,
                                      style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                    ),
                                  ),
                                  // Add a line between other product info and main info
                                  Padding(padding: EdgeInsets.only(top: 10, bottom: 10), child: Divider()),
                                  Text("Outras informações", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                                  SizedBox(height: 10),
                                  if (deliveries[jobSelected].productDetails.height != 0 && deliveries[jobSelected].productDetails.width != 0 && deliveries[jobSelected].productDetails.length != 0)
                                  RichText(
                                    text: TextSpan(
                                    text: 'Dimensões: ',
                                    style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                      text: "${deliveries[jobSelected].productDetails.height} x ${deliveries[jobSelected].productDetails.width} x ${deliveries[jobSelected].productDetails.length} cm",
                                      style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                    ),
                                  ),
                                  if (deliveries[jobSelected].productDetails.weight != 0)
                                  RichText(
                                    text: TextSpan(
                                    text: 'Peso: ',
                                    style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                      text: "${deliveries[jobSelected].productDetails.weight} kg",
                                      style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 10, bottom: 10), child: Divider()),
                                  RichText(
                                    text: TextSpan(
                                    text: 'Situação: ',
                                    style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                      text: () {
                                        switch (deliveries[jobSelected].status) {
                                        case DeliveryStatus.pending:
                                          return 'Pendente';
                                        case DeliveryStatus.onCourse:
                                          return 'Em trânsito';
                                        case DeliveryStatus.completed:
                                          return 'Entregue';
                                        default:
                                          return 'Desconhecido';
                                        }
                                      }(),
                                      style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 20),
                      DFullFilledButton(
                        child: Text('Aceitar demanda'),
                        onClick: () async {
                          setState(() {
                            jobSelected = -1;
                            points = [];
                          });
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  )
                );
              },
            ),
          ]
        )
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}