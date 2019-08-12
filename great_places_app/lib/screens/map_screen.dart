import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_app/models/location.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  const MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 37.422, longitude: -122.084),
      this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() => pickedLocation = position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: pickedLocation == null
                  ? null
                  : () => Navigator.of(context).pop(pickedLocation),
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 15,
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (pickedLocation == null && widget.isSelecting)
            ? null
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: pickedLocation ??
                      LatLng(widget.initialLocation.latitude,
                          widget.initialLocation.longitude),
                ),
              },
      ),
    );
  }
}
