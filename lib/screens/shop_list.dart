import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_shopping_admin/components/drawer/drawer.dart';
import 'package:my_shopping_admin/product_data/product_data.dart';
import 'package:my_shopping_admin/screens/test.dart';
import 'package:my_shopping_admin/service.dart';

import '../items/shopping_cart.dart';
import 'add_prodect_screen/add_product_screen.dart';

class ShopListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShopListState();
  }
}

class _ShopListState extends State<ShopListWidget> {

  late final void Function(Product model) onItemTap;

  List<String> pictureUrls = [];

  String selectedCategory = 'Barchasi';

  List<Product> getFilteredItems(String category) {
    if (category == 'Stullar') {
      print('--------------------Stullar qaytdi');
      return productList
          .where((item) => item.categoriesName == category)
          .toList();
    }else if(category == 'Stollar'){
      print('--------------------Stollar qaytdi');
      return productList
          .where((item) => item.categoriesName == category)
          .toList();
    }else if(category == 'Dekoratsiya'){
      print('--------------------Dekoratsiya qaytdi');
      return productList
          .where((item) => item.categoriesName == category)
          .toList();
    } else {
      return productList;
    }
  }

  final controller = DragSelectGridViewController();
  static List<Product> productList = [];
  List<Product> list=[];

  @override
  void initState() {
    super.initState();
    setState(() {
      getAllProductList();
    });
    getFilteredItems(selectedCategory);
    controller.addListener(scheduleRebuild);
    fetchImageUrlsFromStorage("images/");
  }

  @override
  void dispose() {
    controller.removeListener(scheduleRebuild);
    super.dispose();
  }

  void scheduleRebuild() => setState(() {});

  static Future<List<Product>> getAllProductList() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('productsumg').get();
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Product product = Product(
          id: doc.id,
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          price: data['price'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
          isAvailable: data['isAvailable'] ?? false,
          categoriesName: data['categoriesName'] ?? '',
        );
        productList.add(product);
      }
      );
        return productList;
    } catch (e) {
      print('Error getting products: $e');
    }
    return productList;
  }

   fetchImageUrlsFromStorage(String storagePath) async {
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

  @override
  Widget build(BuildContext context) {

    final List<String> categories = ['Stullar','Barchasi', 'Stollar','Dekoratsiya'];

    return Scaffold(
        drawer: const UserCabinet(),
        appBar: AppBar(
          key: const Key('selecting'),
          titleSpacing: 0,
          backgroundColor: Colors.lightBlueAccent,
          actions: [
            DropdownButton<String>(
              dropdownColor: Colors.grey,
              underline: Container(
                color: Colors.black,
              ),
              value: selectedCategory,
              style: const TextStyle(color: Colors.white),
              iconDisabledColor: Colors.white,
              iconEnabledColor: Colors.white,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                }
              },
              items:
              categories.map<DropdownMenuItem<String>>((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),),
          ],
          title: Text(
            "Dekoratsiyalar",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DragSelectGridView(
            padding: const EdgeInsets.all(8),
            itemCount: getFilteredItems(selectedCategory).length,
            itemBuilder: (context, index, selected) {
              return SelectableItem(
                index: index,
                color: Colors.grey,
                selected: selected,
                text: getFilteredItems(selectedCategory)[index].name,
                pictureUrls: pictureUrls[index % pictureUrls.length],
                price: '${getFilteredItems(selectedCategory)[index].price} so`m',
                description: getFilteredItems(selectedCategory)[index].description,
                categoriesName: getFilteredItems(selectedCategory)[index].categoriesName,
              );
            },
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: MediaQuery.of(context).size.width * 0.7),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black54,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddProduct()));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}

// Your _ShopListItem and other helper methods remain the same
