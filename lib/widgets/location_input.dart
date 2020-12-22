import 'package:camera_map_location/helper/location_helper.dart';
import 'package:camera_map_location/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImages;
  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        lat,
        lng
    );
    setState(() {
      _previewImages = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locationData = await Location().getLocation();
      _showPreview(locationData.latitude, locationData.longitude);
      widget.onSelectPlace(locationData.latitude, locationData.longitude);
    } catch(error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
        MaterialPageRoute(
          //fullscreenDialogをtrueにすることで、×を押して戻るUIになる
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(
              isSelecting: true,
            ),
        ),
    );
    if(selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: Colors.grey
              )
          ),
          child: _previewImages == null
              ? Text(
                'No image choosen',
                textAlign: TextAlign.center,
          )
          : Image.network(
            _previewImages,
            fit: BoxFit.cover,
            width: double.infinity,
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentLocation
          ),
          FlatButton.icon(
            icon: Icon(Icons.map),
            label: Text('Select on map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _selectOnMap,
          )
        ],)
      ],
    );
  }
}

