import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/screens/add_place.dart';
import 'package:great_places_app/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  static const routeName = '/places-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Great Places'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchPlaces(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Consumer<GreatPlaces>(
            child: Center(
              child: Text('Got no places yet, start adding some!'),
            ),
            builder: (ctx, greatPlaces, child) => greatPlaces.items.length <= 0
                ? child
                : ListView.builder(
                    itemCount: greatPlaces.items.length,
                    itemBuilder: (ctx, idx) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            FileImage(greatPlaces.items[idx].image),
                      ),
                      title: Text(greatPlaces.items[idx].title),
                      subtitle: Text(greatPlaces.items[idx].location.address),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            PlaceDetailScreen.routeName,
                            arguments: greatPlaces.items[idx].id);
                      },
                    ),
                  ),
          );
        },
      ),
    );
  }
}
