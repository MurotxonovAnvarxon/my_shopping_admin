import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_shopping_admin/product_data/product_data.dart';
import 'package:my_shopping_admin/screens/add_prodect_screen/selling_product_data.dart';

class ProductService {
  static Future<void> addProductToFirestore({
    required String id,
    required String name,
    required String description,
    required String price,
    required String imageUrl,
    required bool isAvailable,
    required String categoriesName,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('productsumg').doc(id).set({
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'isAvailable': isAvailable,
        'categoriesName': categoriesName,
      });
      print('Product added to Firestore successfully!');
    } catch (e) {
      print('Failed to add product: $e');
    }
  }

  static List<Product> productList = [];
  static List<SellingProduct> sellingProducts = [];

  static Future<void> fetchSellProductFromFirestore(String documentId) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('sellProducts')
          .doc(documentId)
          .get();
      final docSnapshotDocumentId =
          await FirebaseFirestore.instance.collection('sellProducts').get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        // var id = docSnapshotDocumentId.docs.forEach((element) {
        //   ids.add(element.id);
        // });
        // Do something with the retrieved data
        var list=data;
        print('Retrieved data: $data');
        // print('-------------------------------id: ${ids.toString()}');

      } else {
        print('Document does not exist!');
      }
    } catch (e) {
      print('Failed to fetch product: $e');
    }
  }

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
      });
    } catch (e) {
      print('Error getting products: $e');
    }
    return productList;
  }

  static CollectionReference sellProducts =
      FirebaseFirestore.instance.collection('sellProducts');

  // static Stream<List<SellingProduct>> getAllSellings() {
  //   sellProducts.add(sellProducts.snapshots().map((snapshot) => snapshot.docs
  //       .map((e) => SellingProduct.fromJson(
  //             e.data() as Map<String, dynamic>,
  //           ))
  //       .toList()));
  //   return sellProducts.snapshots().map((snapshot) => snapshot.docs
  //       .map((e) => SellingProduct.fromJson(
  //             e.data() as Map<String, dynamic>,
  //           ))
  //       .toList());
  // }

  static Future<List<SellingProduct>> getAllSellingProduct() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('sellProducts').get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        String id = data['phone'];
        String date = data['date'];

        List<Product> productList = [];
        List<dynamic> productsData = data['list'];
        for (Map<String, dynamic> productData in productsData) {
          Product product =
              Product.fromFirestore(productData as DocumentSnapshot<Object?>);
          productList.add(product);
        }

        SellingProduct sellingProduct = SellingProduct(
          phone: id,
          date: date,
          products: productList,
        );

        sellingProducts.add(sellingProduct);
      }
      print("selling!!!!!!!!${sellingProducts}");
      print('Selling products retrieved successfully!');
    } catch (e) {
      print('Failed to retrieve selling products: $e');
    }

    return sellingProducts;
  }
}
