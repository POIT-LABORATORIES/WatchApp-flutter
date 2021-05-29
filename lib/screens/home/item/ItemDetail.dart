import 'package:flutter/material.dart';
import 'package:watchapp/models/item.dart';
import 'package:watchapp/screens/Loading.dart';
import 'package:watchapp/screens/home/item/ItemDetailSheet.dart';
import 'package:watchapp/services/database.dart';

class ItemDetail extends StatefulWidget {
  ItemDetail({this.item});

  final Item item;

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  final FirestoreService _db = FirestoreService(FirestoreCollectionKey.watches);
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text(widget.item.name),
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.delete_forever),
                    tooltip: 'Delete item',
                    onPressed: () async {
                      setState(() => loading = true);
                      try {
                        await _db.deleteDocument(widget.item.id);

                        Navigator.pop(context);
                      } catch (e) {
                        setState(() => loading = false);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Error occurred while trying to delete the item")));
                      }
                    })
              ],
            ),
            body: SingleChildScrollView(
              child: ItemDetailSheet(item: widget.item),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                /*
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ItemCreate()));
              */
              },
              child: Icon(Icons.edit_outlined),
              backgroundColor: Colors.blue,
            ),
          );
  }
}
