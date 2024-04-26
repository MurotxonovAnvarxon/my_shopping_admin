import 'package:dio/dio.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_shopping_admin/components/drawer/drawer.dart';
import 'package:my_shopping_admin/items/item_grid.dart';
import 'package:my_shopping_admin/orderScreen.dart';
import 'package:my_shopping_admin/product_data/product_data.dart';
import 'package:my_shopping_admin/screens/detail_page.dart';
import 'package:my_shopping_admin/screens/home_screen.dart';
import 'package:my_shopping_admin/screens/items_page.dart';
import 'package:my_shopping_admin/screens/test.dart';
import 'package:my_shopping_admin/utils/colors.dart';

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
  late final void Function(Product model) onItemTap;

  List<String> pictureUrls = [];

  // void getProduct(String id) async {
  //   String productId = id;
  //   Product? product = await ProductService.getProductById(productId);
  //   if (product != null) {
  //     print('-------------------------------------------------');
  //     print('Retrieved Product:');
  //     print('Name: ${product.name}');
  //     print('Description: ${product.description}');
  //     print('Price: ${product.price}');
  //     print('Image URL: ${product.imageUrl}');
  //     print('Available: ${product.isAvailable}');
  //     print('Category: ${product.categoriesName}');
  //     print('-------------------------------------------------');
  //   } else {
  //     print('Product not found!');
  //   }
  // }

  final controller = DragSelectGridViewController();

  @override
  void initState() {
    super.initState();
    ProductService.getAllProductList();
    controller.addListener(scheduleRebuild);
    fetchImageUrlsFromStorage("images/");
  }

  @override
  void dispose() {
    controller.removeListener(scheduleRebuild);
    super.dispose();
  }

  void scheduleRebuild() => setState(() {});

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
        print('--------------------------------------------------');
        print('Product Name: $productName');
        print('Product Description: $productDescription');
        print('Product Price: $productPrice');
        print('Product Categories: $productCategories');
        print('Image URL: $imageUrl');
        print('--------------------------------------------------');

        print('Image and product details displayed successfully.');
      } else {
        print(
            'Failed to load data. Response status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error retrieving data: $e');
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
        appBar: SelectionAppBar(
          selection: controller.value,
          title: Center(
            child: Text(
              "Decoration Shop",
              style: TextStyle(color: Colors.white),
            ),
          ),
          list: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProduct()));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ],
        )
        /*AppBar(
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
      )*/
        ,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DragSelectGridView(
            // gridController: controller,
            padding: const EdgeInsets.all(8),
            itemCount: pictureUrls.length,
            itemBuilder: (context, index, selected) {
              return SelectableItem(
                index: index,
                color: Colors.grey,
                selected: selected,
                text: ProductService.productList[index].name,
                pictureUrls: pictureUrls[index % pictureUrls.length],
                price: '${ProductService.productList[index].price} so`m',
                description: ProductService.productList[index].description,
                categoriesName: ProductService.productList[index].categoriesName,
              );
            },
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: MediaQuery.of(context).size.width * 0.7),
          ),
          /*GridView.count(
          crossAxisCount: 2,
          children: List.generate(pictureUrls.length, (index) {
            return Column(
              children: [
                Container(
                  child: Image.network(
                    pictureUrls[index % pictureUrls.length],
                    fit: BoxFit.cover,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      getProduct(pictureUrls[index]);
                    },
                    child: Text(ProductService.productList[index].name)),
              ],
            );
          }),
        )*/
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black54,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddProduct()));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ) /*cart.isEmpty
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
            ),*/
        );
  }
}

// Your _ShopListItem and other helper methods remain the same
