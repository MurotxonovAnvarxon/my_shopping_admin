import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shopping_admin/screens/test.dart';
import 'package:my_shopping_admin/service.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var sellList=ProductService.sellProductList;

  @override
  void initState() {
    ProductService.getAllSellingProductsFromFirestore();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DragSelectGridView(
          // gridController: controller,
          padding: const EdgeInsets.all(8),
          itemCount: sellList.length,
          itemBuilder: (context, index, selected) {
            return SelectableItem(
              index: index,
              color: Colors.grey,
              selected: selected,
              text: sellList[index].date,
              pictureUrls: /*pictureUrls[index % pictureUrls.length]*/'',
              price: '${ProductService.productList[index].price} so`m',
              description: sellList[index].phone,
              categoriesName: sellList[index].phone,
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
    );
  }
}
