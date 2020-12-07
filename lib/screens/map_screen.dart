import 'package:camera_map_location/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen({this.initialLocation = const PlaceLocation(latitude: 37.422, longitude: -122.084), this.isSelecting =false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your map'),
      ),
      body: GoogleMap(initialCameraPosition: CameraPosition(
          target: LatLng(
              widget.initialLocation.latitude,
              widget.initialLocation.longitude
          ),
          zoom: 16
      )),
    );
  }
}
