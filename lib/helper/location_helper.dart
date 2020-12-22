import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_APT_KEI = 'AIzaSyDx_pmIEdKVd-Gx_LDby591UshHCkzt-jw';

class LocationHelper {
  static String generateLocationPreviewImage(double latitude, double longitude) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_APT_KEI';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_APT_KEI';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];

  }
}