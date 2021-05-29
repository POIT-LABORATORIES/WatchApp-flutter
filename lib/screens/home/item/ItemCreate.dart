import 'dart:io';
import 'package:flutter/material.dart';
import 'package:watchapp/models/item.dart';
import 'package:watchapp/screens/Loading.dart';
import 'package:watchapp/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ItemCreate extends StatefulWidget {
  @override
  _ItemCreateState createState() => _ItemCreateState();
}

class _ItemCreateState extends State<ItemCreate> {
  final FirestoreService _firestore =
      FirestoreService(FirestoreCollectionKey.watches);
  final StorageService _storage = StorageService(path: StoragePathKey.images);
  final _formKey = GlobalKey<FormState>();
  File _image;
  final picker = ImagePicker();
  bool loading = false;

  String name = '';
  String style = '';
  String caseColor = '';
  String caseMaterial = '';
  String latitude = '';
  String longitude = '';
  String description = '';

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text("Create new item"),
            ),
            body: SingleChildScrollView(
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Name"),
                          onChanged: (val) {
                            setState(() => name = val);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter item name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Style"),
                          onChanged: (val) {
                            setState(() => style = val);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter style';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Case color"),
                          onChanged: (val) {
                            setState(() => caseColor = val);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter case color';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration:
                              InputDecoration(hintText: "Case material"),
                          onChanged: (val) {
                            setState(() => caseMaterial = val);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter case material';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Description"),
                          onChanged: (val) {
                            setState(() => description = val);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter description';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Latitude"),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          onChanged: (val) {
                            try {
                              setState(() => latitude = val);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Wrong latitude value")));
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter latitude';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Longitude"),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          onChanged: (val) {
                            try {
                              setState(() => longitude = val);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Wrong longitude value")));
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter longitude';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () async {   
                            if (_formKey.currentState.validate()) {
                              try {
                                if (_image == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Image is not picked")));
                                  return;
                                }

                                setState(() => loading = true);
                                String url = await _storage.uploadFile(
                                    '$name-avatar', _image);

                                String uuid = Uuid()
                                .v5(Uuid.NAMESPACE_URL, 'www.google.com');
                                Item item = Item(
                                  id: uuid,
                                  name: this.name,
                                  style: this.style,
                                  caseColor: this.caseColor,
                                  caseMaterial: this.caseMaterial,
                                  description: this.description,
                                  latitude: double.parse(this.latitude),
                                  longitude: double.parse(this.longitude),
                                  avatarUrl: url
                                );

                                await _firestore.addDocument(uuid, item.toJson());

                                Navigator.pop(context);
                              } catch (e) {
                                setState(() => loading = false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Image is not picked")
                                  )
                                );
                              }
                            }
                          },
                          child: Text("Create"),
                        )
                      ]))),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: getImage,
              tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
            ),
          );
  }
}
