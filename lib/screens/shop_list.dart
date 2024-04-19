import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_shopping_admin/components/drawer/drawer.dart';
import 'package:my_shopping_admin/product_data/product_data.dart';
import '../items/shopping_cart.dart';
import '../service.dart';
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

  void getProduct(String id) async {
    String productId = id;
    Product? product = await ProductService.getProductById(productId);
    if (product != null) {
      print('-------------------------------------------------');
      print('Retrieved Product:');
      print('Name: ${product.name}');
      print('Description: ${product.description}');
      print('Price: ${product.price}');
      print('Image URL: ${product.imageUrl}');
      print('Available: ${product.isAvailable}');
      print('Category: ${product.categoriesName}');
      print('-------------------------------------------------');
    } else {
      print('Product not found!');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchImageUrlsFromStorage(
        "images/"); // Change "images/" to your storage path
  }

  Future<void> fetchImageUrlsFromStorage(String storagePath) async {
    try {
      Reference storageRef = FirebaseStorage.instance.ref().child(storagePath);

      ListResult listResult = await storageRef.listAll();

      List<String> urls = [];
      await Future.forEach(listResult.items, (Reference itemRef) async {
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

  List<Product> productList = [];

  Future<void> displayImageFromFirestore(
    String id,
    String productName,
    String productDescription,
    String productPrice,
    String productCategories,
  ) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://your-firestore-project-url.com/productLast/$id.json',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;

        final String imageUrl = responseData['imageUrl'] ?? '';

        // Display image and product details on screen (for demonstration purposes)
        print('--------------------------------------------------');
        print('Product Name: $productName');
        print('Product Description: $productDescription');
        print('Product Price: $productPrice');
        print('Product Categories: $productCategories');
        print('Image URL: $imageUrl');
        print('--------------------------------------------------');

        // You can use the retrieved data to display it on the screen using widgets
        // For example, use Image.network to display the image:
        // Image.network(imageUrl)

        print('Image and product details displayed successfully.');
      } else {
        print(
            'Failed to load data. Response status code: ${response.statusCode}');
        // Handle unsuccessful response, display error message, or notify user accordingly
      }
    } catch (e) {
      print('Error retrieving data: $e');
      // Handle error, display error message, or notify user accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    final columnCount =
        MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4;
    final width = MediaQuery.of(context).size.width / columnCount;
    const height = 400;

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
            icon: const Icon(Icons.add),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom:
                Radius.circular(20), // Radiusni istalgan qiymatga o'zgartiring
          ),
        ),
        title: const Center(
          child: Text(
            "Decoration Shop",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: pictureUrls.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Wrap(children: [
                  // Image.network(
                  //   pictureUrls[index % pictureUrls.length],
                  //   fit: BoxFit.cover, // Adjust image fit as needed
                  //   width: MediaQuery.of(context).size.width / 2.2,
                  //   height: MediaQuery.of(context).size.width / 2.2,
                  // ),
                ]),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(onPressed: () {
                    getProduct(pictureUrls[index]);
                  }, child: Text('click')),
                )
              ],
            );
          },
        ),
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
