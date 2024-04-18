import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_shopping_admin/components/drawer/drawer.dart';
import 'package:my_shopping_admin/items/item.dart';

import '../items/shopping_cart.dart';
import 'add_prodect_screen/add_product_screen.dart';
import 'cart_list.dart';

class ShopListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShopListState();
  }
}

class _ShopListState extends State<ShopListWidget> {
  ShoppingCart cart = ShoppingCart();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // final List<Item> items = Item.dummyItems;
  List<String> pictureUrls = [];

  @override
  void initState() {
    super.initState();
    fetchImageUrlsFromStorage("images/"); // Change "images/" to your storage path
  }

  Future<void> fetchImageUrlsFromStorage(String storagePath) async {
    try {
      // Create a reference to the desired path in Firebase Storage
      Reference storageRef = FirebaseStorage.instance.ref().child(storagePath);

      // List all items (files and directories) within the specified path
      ListResult listResult = await storageRef.listAll();

      List<String> urls = [];
      // Iterate through each item (file) in the list result
      await Future.forEach(listResult.items, (Reference itemRef) async {
        // Get the download URL for the image
        String downloadUrl = await itemRef.getDownloadURL();
        urls.add(downloadUrl);
      });

      setState(() {
        pictureUrls = urls;
      });
    } catch (e) {
      print('Error retrieving image URLs from Firebase Storage: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final columnCount = MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4;
    final width = MediaQuery.of(context).size.width / columnCount;
    const height = 400;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const UserCabinet(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
            },
            icon: const Icon(Icons.add),
          )
        ],
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Radiusni istalgan qiymatga o'zgartiring
          ),
        ),
        title: const Center(
          child: Text(
            "Decoration Shop",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: pictureUrls.length,
        itemBuilder: (context, index) {
          // Item item = pictureUrls[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[200], // Placeholder color
              ),
              child: pictureUrls.isNotEmpty
                  ? Image.network(
                pictureUrls[index % pictureUrls.length], // Cycle through URLs
                fit: BoxFit.cover, // Adjust image fit as needed
                width: double.infinity,
                height: 200,
                // Set desired image height
              )
                  : Icon(Icons.image_not_supported), // Placeholder if no image
            ),
          );
        },
      ),
      floatingActionButton: cart.isEmpty
          ? null
          : FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CartListWidget(
              cart: this.cart,
            ),
          ));
        },
        icon: Icon(Icons.shopping_cart),
        label: Text("${cart.numOfItems}"),
      ),
    );
  }
}

// Your _ShopListItem and other helper methods remain the same
