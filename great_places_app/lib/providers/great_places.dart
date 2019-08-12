import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places_app/helpers/db_helper.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import 'package:great_places_app/models/location.dart';
import 'package:great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  static const TABLE_NAME = 'places';

  List<Place> _items = [];

  List<Place> get items => [..._items];

  Place findById(String id) => _items.firstWhere((place) => place.id == id);

  void addPlace(String title, File image, PlaceLocation location) async {
    final address = await LocationHelper.getPlaceAddress(
      latitude: location.latitude,
      longitude: location.longitude,
    );
    final updatedLocation = PlaceLocation(
      latitude: location.latitude,
      longitude: location.longitude,
      address: address,
    );
    final place = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: updatedLocation,
    );
    _items.add(place);
    notifyListeners();

    DBHelper.insert(TABLE_NAME, {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'loc_lat': place.location.latitude,
      'loc_lng': place.location.longitude,
      'address': place.location.address,
    });
  }

  Future<void> fetchPlaces() async {
    final dataList = await DBHelper.getData(TABLE_NAME);
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: PlaceLocation(
                latitude: item['loc_lat'],
                longitude: item['loc_lng'],
                address: item['address'],
              ),
            ))
        .toList();

    notifyListeners();
  }
}
