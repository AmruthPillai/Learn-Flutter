import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();

  File _storedImage;

  Future<void> _takePicture() async {
    final file = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (file == null) return;

    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(file.path);
    final image = await file.copy('${appDir.path}/$filename');

    setState(() => _storedImage = image);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _storedImage == null) return;
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _storedImage);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Place'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Name of the Place',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    _storedImage != null
                        ? Image.file(
                            _storedImage,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: double.infinity,
                            height: 120,
                            child: FlatButton.icon(
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              icon: Icon(Icons.camera),
                              label: Text('Take Picture'),
                              onPressed: _takePicture,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          FlatButton.icon(
            textColor: Theme.of(context).accentColor,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed: _savePlace,
          )
        ],
      ),
    );
  }
}
