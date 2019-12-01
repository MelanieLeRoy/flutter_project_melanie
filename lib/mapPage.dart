import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'Venue.dart';

class Maps extends StatelessWidget {
  final Venue venue;

  Maps({Key key, @required this.venue}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MapsPage(venue: this.venue),
    );
  }
}

class MapsPage extends StatefulWidget {
  final Venue venue;

  MapsPage({Key key, @required this.venue}) : super(key: key);
  @override
  _MapsState createState() => new _MapsState(this.venue);
}

class _MapsState extends State<MapsPage> {
  final Venue venue;

  _MapsState(this.venue);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(venue.name)),
      body: new FlutterMap(
        options: new MapOptions(
          center: new LatLng(venue.location.lat, venue.location.lng),
          zoom: 13.0,
        ),
        layers: [
          new TileLayerOptions(
            urlTemplate: "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token=pk.eyJ1IjoibWFyc2hhbGxqciIsImEiOiJjazNlbjV0a3gwMDFqM2VvOTJhYXZ0cGhqIn0.CYRG0gZZhBiPZKYnUJmf8Q",
            additionalOptions: {
              'accessToken': 'pk.eyJ1IjoibWFyc2hhbGxqciIsImEiOiJjazNlbjV0a3gwMDFqM2VvOTJhYXZ0cGhqIn0.CYRG0gZZhBiPZKYnUJmf8Q',
              'id': 'mapbox.streets-satellite',
            },
          ),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                  width: 45.0,
                  height: 45.0,
                  point: new LatLng(venue.location.lat, venue.location.lng),
                  builder: (context) =>
                  new MaterialButton(
                    child: IconButton(
                      icon: Icon(Icons.room),
                      color: Colors.red,
                      tooltip: "efgsrv" + venue.name,
                      iconSize: 45.0,
                      onPressed: () {
                        print(venue.name);
                      },
                    ),
                  ))
            ],
          ),
        ]
        ,
      ),
    );
  }
}
