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
  static List<SellingProduct> sellProductList = [];

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

  static Future<List<SellingProduct>> getAllSellingProductsFromFirestore() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('sellProducts').get();

      List<SellingProduct> sellingProducts = [];

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;

        List<Product> products = (data['list'] as List<dynamic>).map((productData) {
          return Product.fromFirestore(productData);
        }).toList();

        SellingProduct sellingProduct = SellingProduct(
          phone: data['id'],
          date: data['date'],
          products: products,
        );

        sellingProducts.add(sellingProduct);
      }

      print('All selling products: $sellingProducts');
      return sellingProducts;
    } catch (e) {
      print('Failed to get all selling products: $e');
      return []; // Empty list if there's an error
    }
  }




  static Future<Product?> getProductById(String id) async {
    try {
      DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('productsumg')
          .doc(id)
          .get();

      if (productSnapshot.exists) {
        Map<String, dynamic> data =
            productSnapshot.data() as Map<String, dynamic>;
        return Product(
          id: id,
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          price: data['price'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
          isAvailable: data['isAvailable'] ?? false,
          categoriesName: data['categoriesName'] ?? '',
        );
      } else {
        print('Product with ID $id does not exist.');
        return null;
      }
    } catch (e) {
      print('Error fetching product: $e');
      return null;
    }
  }


}
