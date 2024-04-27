import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shopping_admin/screens/test.dart';
import 'package:my_shopping_admin/service.dart';
import 'package:intl/intl.dart';

class SellingDetail extends StatefulWidget {
  String id;

  SellingDetail({super.key, required this.id});

  @override
  State<SellingDetail> createState() => _SellingDetailState();
}

class _SellingDetailState extends State<SellingDetail> {
  var data;
  List<String> pictureUrls = [];

  @override
  void initState() {
    print("--------------data:${data.toString()}");
    fetchImageUrlsFromStorage("images/");
    data = ProductService.fetchSellProductsFromFirestore(widget.id);

    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (context) {
          if (ProductService.date?.substring(0, 10) != null) {
            return Text("Sana:${ProductService?.date.substring(0, 10)}");
          } else {
            return CircularProgressIndicator();
          }
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Builder(builder: (context) {
          if (ProductService.date.substring(0, 10) == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return DragSelectGridView(
              // gridController: controller,
              padding: const EdgeInsets.all(8),
              itemCount: ProductService.prd.length,
              itemBuilder: (context, index, selected) {
                return SelectableItem(
                  index: index,
                  color: Colors.grey,
                  selected: selected,
                  text: ProductService.prd[index].name,
                  pictureUrls: pictureUrls[index % pictureUrls.length],
                  price: ProductService.prd[index].price,
                  description: ProductService.prd[index].description,
                  categoriesName: ProductService.prd[index].categoriesName,
                );
              },
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  mainAxisExtent: MediaQuery.of(context).size.width * 0.7),
            );
          }
        }),
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
    );
  }
}
