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
        itemCount: ProductService.sellingProducts.length,
        itemBuilder: (context, index) {
         return SelectableItem(
           index: index,
           color: Colors.grey,
           selected: false,
           text: ProductService.sellingProducts[index].date,
           pictureUrls: ProductService.sellingProducts[index].date,
           price: '${ProductService.sellingProducts[index].phone} ',
           description: ProductService.sellingProducts[index].phone,
           categoriesName: ProductService.sellingProducts[index].phone,
         );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        print('-------------------------------------${ProductService.sellingProducts.length}');
      },),
    );
  }
}
