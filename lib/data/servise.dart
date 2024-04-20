import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_shopping_admin/product_data/product_data.dart';

// class ProductService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Productlarni olish
//   Future<List<Product>> getAllProducts() async {
//     List<Product> products = [];
//     try {
//       QuerySnapshot querySnapshot = await _firestore.collection('products').get();
//       querySnapshot.docs.forEach((doc) {
//         Product product = Product.fromFirestore(doc);
//         products.add(product);
//       });
//     } catch (e) {
//       print('Error getting products: $e');
//     }
//     return products;
//   }
//
//   // Bir produktni ID boyicha olish
//   Future<Product?> getProductById(String id) async {
//     try {
//       DocumentSnapshot docSnapshot = await _firestore.collection('products').doc(id).get();
//       if (docSnapshot.exists) {
//         return Product.fromFirestore(docSnapshot);
//       } else {
//         print('Product not found with id: $id');
//         return null;
//       }
//     } catch (e) {
//       print('Error getting product by id: $e');
//       return null;
//     }
//   }
//
//   // Yaratilgan productni qo'shish
//   Future<void> addProduct(Product product) async {
//     try {
//       await _firestore.collection('products').doc(product.id).set(product.toMap());
//       print('Product added successfully');
//     } catch (e) {
//       print('Error adding product: $e');
//     }
//   }
//
//   // Produkt ma'lumotlarini yangilash
//   Future<void> updateProduct(Product product) async {
//     try {
//       await _firestore.collection('products').doc(product.id).update(product.toMap());
//       print('Product updated successfully');
//     } catch (e) {
//       print('Error updating product: $e');
//     }
//   }
//
//   // Produkt o'chirish
//   Future<void> deleteProduct(String id) async {
//     try {
//       await _firestore.collection('products').doc(id).delete();
//       print('Product deleted successfully');
//     } catch (e) {
//       print('Error deleting product: $e');
//     }
//   }
// }
