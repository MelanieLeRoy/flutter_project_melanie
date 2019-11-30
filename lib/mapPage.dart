import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Venue.dart';

class MapDisplay extends StatelessWidget {
  // This widget is the root of your application.
  final Venue venue;

  MapDisplay({Key key, this.venue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this.venue.name,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapPage(title: this.venue.name, venue: this.venue),
    );
  }
}

class MapPage extends StatefulWidget {
  final String title;
  final Venue venue;

  MapPage({Key key, this.title, this.venue}) : super(key: key);

  @override
  State<MapPage> createState() {
    return _MapPageState(this.venue);
  }
}

class _MapPageState extends State<MapPage> {
  final Venue venue;

  _MapPageState(this.venue);

  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
