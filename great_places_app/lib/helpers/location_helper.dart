import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyCQ-IRN1K7AHfzkSXtnFI1qkk2VJoC98KM';

class LocationHelper {
  static String generateLocationPreviewImage(
          {double latitude, double longitude}) =>
      'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=15&size=600x300&maptype=roadmap&markers=color:red%7C$latitude,$longitude&key=$GOOGLE_API_KEY';

  static Future<String> getPlaceAddress(
      {double latitude, double longitude}) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
