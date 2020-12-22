import 'package:camera_map_location/helper/db_helper.dart';
import 'package:flutter/cupertino.dart';
import '../models/place.dart';
import 'dart:io';
import 'package:camera_map_location/helper/db_helper.dart';
import 'package:camera_map_location/helper/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
      String pickedTitle,
      File pickedImage,
      PlaceLocation pickedLocation
      ) async {
      final address = await LocationHelper.getPlaceAddress(pickedLocation.latitude, pickedLocation.longitude);
      final updateLocation = PlaceLocation(
          latitude: pickedLocation.latitude,
          longitude: pickedLocation.longitude,
          address: address
      );
      final newPlace = Place(
        id: DateTime.now().toString(),
        title: pickedTitle,
        location: updateLocation,
        image: pickedImage,
      );
      _items.add(newPlace);
      notifyListeners();
      DBHelper.insert('user_places', {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat':newPlace.location.latitude,
        'loc_lng':newPlace.location.longitude,
        'address':newPlace.location.address
      });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    //add date to _item list
    _items = dataList.map((item) => Place(
          id: item['id'],
          title: item['title'],
          image: File(item['image']),
          location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address']
          )
        )
    ).toList();
    notifyListeners();
  }

}