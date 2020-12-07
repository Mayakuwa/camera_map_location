import 'package:camera_map_location/helper/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImages;

  Future<void> _getCurrentLocation() async {
    final locationData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        locationData.latitude,
        locationData.longitude
    );
    setState(() {
      _previewImages = staticMapImageUrl;
    });
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
            onPressed: () {},
          )
        ],)
      ],
    );
  }
}

