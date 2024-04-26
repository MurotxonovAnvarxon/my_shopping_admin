import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_shopping_admin/service.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var sellList = [];
  static List<String> ids = [];

  Future<void> _init() async {
    final docSnapshot = await FirebaseFirestore.instance.collection('sellProducts').get();
    setState(() {
      ids = docSnapshot.docs.map((doc) => doc.id).toList();
      removeDuplicates(); // Dublikatlarni o'chiramiz
    });
  }

  void removeDuplicates() {
    setState(() {
      ids = ids.toSet().toList();
    });
  }

  @override
  void initState() {
    _init();

    // for (int i = 0; i < ids.length; i++) {
    //   sellList.add(ProductService.fetchSellProductFromFirestore(i.toString()));
    // }
    super.initState();
  }

  // @override
  // void initState() {
  //   sellList=  ProductService.sellingProducts;
  //   ProductService.getAllSellingProduct();
  //   print("#################sellproducts:${ProductService.sellingProducts}");
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scaffold(
        body: ListView.builder(
            itemCount: ids.length,
            itemBuilder: (context, index) {
              return Text("${ids[index]}");
            }),
      ),
    );
  }
}
