import 'package:flutter/material.dart';
import 'package:watchapp/screens/Loading.dart';
import 'package:watchapp/services/database.dart';
import 'package:image_picker/image_picker.dart';

class ItemCreate extends StatefulWidget {
  @override
  _ItemCreateState createState() => _ItemCreateState();
}

class _ItemCreateState extends State<ItemCreate> {
  final DatabaseService _dbWatches = DatabaseService(FirestoreCollectionKey.watches);
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String name = '';
  String style = '';
  String caseColor = '';
  String caseMaterial = '';
  double latitude = 0;
  double longitude = 0;
  String description = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Create new item"),
      ),
      body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
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
                    decoration: InputDecoration(hintText: "Case material"),
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
                        setState(() => latitude = val as double);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                        setState(() => longitude = val as double);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                        setState(() => loading = true);

                        // Call Firestore func to upload the item.

                        /*
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(authResult)));
                      */
                      }
                    },
                    child: Text("Create"),
                  )
                ]
                )
            )
        ),
      ),
    );
  }
}
