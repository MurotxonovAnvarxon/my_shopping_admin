import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_shopping_admin/screens/selling_detail.dart';
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
    final docSnapshot =
        await FirebaseFirestore.instance.collection('sellProducts').get();
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
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SellingDetail(id: ids[index])));
                },
                child: CustomListItem(
                  number: ids[index],
                  date: '',
                  name: '',
                ),
              );
            }),
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  final String number;
  final String date;
  final String name;

  CustomListItem(
      {required this.number, required this.date, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            dense: true,
            title: Text(
              number,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Colors.black,
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}
