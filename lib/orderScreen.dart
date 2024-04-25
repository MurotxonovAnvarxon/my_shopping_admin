import 'package:flutter/material.dart';
import 'package:my_shopping_admin/screens/test.dart';
import 'package:my_shopping_admin/service.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});


  @override
  State<StatefulWidget> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  DateTime? _selectedDate;
  List<String> pictureUrls = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Items"),

      ),
      body: ListView.builder(
        itemCount: ProductService.sellProductList.length,
        itemBuilder: (context, index) {
         return SelectableItem(
           index: index,
           color: Colors.grey,
           selected: false,
           text: ProductService.sellProductList[index].name,
           pictureUrls: ProductService.sellProductList[index].date,
           price: '${ProductService.sellProductList[index].price} so`m',
           description: ProductService.sellProductList[index].description,
           categoriesName: ProductService.sellProductList[index].categoriesName,
         );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        print('-------------------------------------${ProductService.sellProductList.length}');
      },),
    );
  }
}
