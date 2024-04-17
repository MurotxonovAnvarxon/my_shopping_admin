import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_shopping_admin/components/drawer/drawer.dart';
import 'package:my_shopping_admin/items/item.dart';
import 'add_prodect_screen/add_product_screen.dart';
import 'cart_list.dart';

import '../items/shopping_cart.dart';

class ShopListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShopListState();
  }
}

class _ShopListState extends State<ShopListWidget> {
  ShoppingCart cart = ShoppingCart();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Item> items = Item.dummyItems;

  File? _image;

  // Future<void> _pickImage() async {
  //   // final picker = ImagePicker();
  //   // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final columnCount =
        MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4;

    final width = MediaQuery.of(context).size.width / columnCount;
    const height = 400;



    List<Widget> items = [];
    for (var x = 0; x < this.items.length; x++) {
      bool isSideLine;
      if (columnCount == 2) {
        isSideLine = x % 2 == 0;
      } else {
        isSideLine = x % 4 != 3;
      }
      final item = this.items[x];

      items.add(_ShopListItem(
        item: item,
        isInCart: cart.isExists(item),
        isSideLine: isSideLine,
        onTap: (item) {
          // _scaffoldKey.currentState?.hideCurrentSnackBar;
          if (cart.isExists(item)) {
            cart.remove(item);
            const SnackBar(content: Text('Item is removed from cart!'));
            // _scaffoldKey.currentState?.showSnackBar(SnackBar(
            //   content: Text('Item is removed from cart!'),
            // ));
          } else if (item.inStock) {
            cart.add(item);
            const SnackBar(content: Text('Item is added to cart!'));
            // _scaffoldKey.currentState?.showSnackBar(SnackBar(
            //   content: Text('Item is added to cart!'),
            // ));
          } else {
            const SnackBar(
              content: Text('Item is out of stock!'),
            );
            // _scaffoldKey.currentState?.showSnackBar(SnackBar(
            //   content: Text('Item is out of stock!'),
            // ));
          }
          setState(() {});
        },
      ));
    }

    return Scaffold(
        key: _scaffoldKey,
        drawer: const UserCabinet(),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddProduct()));
                },
                icon: const Icon(Icons.add))
          ],
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.blueAccent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(
                  20), // Radiusni istalgan qiymatga o'zgartiring
            ),
          ),
          title: const Center(
            child: Text(
              "Decoration Shop",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Stack(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 28.0, left: 28),
            //   child: Align(
            //     alignment: Alignment.topLeft,
            //     child: FloatingActionButton(
            //       onPressed: _pickImage,
            //       tooltip: 'Pick Image',
            //       child: const Icon(Icons.add_a_photo),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 108.0),
            //   child: Container(
            //       child: _image == null
            //           ? const Text('No image selected.')
            //           : Image.file(
            //               _image!,
            //               width: 100,
            //               height: 100,
            //             )),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: GridView.count(
                childAspectRatio: width / height,
                scrollDirection: Axis.vertical,
                crossAxisCount: columnCount,
                children: items,
              ),
            ),
          ],
        ),
        floatingActionButton: cart.isEmpty
            ? null
            : FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CartListWidget(
                            cart: this.cart,
                          )));
                },
                icon: Icon(Icons.shopping_cart),
                label: Text("${cart.numOfItems}"),
              ));
  }
}

class _ShopListItem extends StatefulWidget {
  final Item item;
  final bool isInCart;
  final bool isSideLine;
  dynamic onTap;

  _ShopListItem(
      {required this.item,
      required this.isInCart,
      required this.isSideLine,
      required this.onTap});

  @override
  State<_ShopListItem> createState() => _ShopListItemState();
}

class _ShopListItemState extends State<_ShopListItem> {
  @override
  Widget build(BuildContext context) {
    Border border;
    if (widget.isSideLine) {
      border = Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
          right: BorderSide(color: Colors.grey, width: 0.5));
    } else {
      border = Border(bottom: BorderSide(color: Colors.grey, width: 0.5));
    }

    return InkWell(
        onTap: () => this.widget.onTap(widget.item),
        child: Card(
            // decoration: BoxDecoration(border: border),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 250,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(widget.item.imageUrl),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
            ),
            Text(
              widget.item.name,
              textAlign: TextAlign.center,
            ),
            Text(widget.item.description),
            const Padding(
              padding: EdgeInsets.only(top: 16),
            ),
            Text(
              widget.item.price.toString(),
              textAlign: TextAlign.center,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
            ),
            Text(
                widget.isInCart ? "In Cart" : widget.item.formattedAvailability,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption?.apply(
                    fontSizeFactor: 0.8,
                    color: widget.isInCart
                        ? Colors.blue
                        : widget.item.availabilityColor)),
          ],
        )));
  }
}

Future<String?> downloadImage(String imagePath) async {
  try {
    Reference ref = FirebaseStorage.instance.ref().child(imagePath);
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    print('Error downloading image: $e');
    return null;
  }
}
