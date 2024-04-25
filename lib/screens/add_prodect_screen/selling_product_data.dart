
import 'package:cloud_firestore/cloud_firestore.dart';

class SellingProduct {
  final String id;//
  final String name;//
  final String description;//
  final String price;//
  // final String imageUrl;
  final bool isAvailable;//
  final String categoriesName;//
  final String date;//

  SellingProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    // required this.imageUrl,
    required this.isAvailable,
    required this.categoriesName,
    required this.date
  });

  factory SellingProduct.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return SellingProduct(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? '',
      // imageUrl: data['imageUrl'] ?? '',
      isAvailable: data['isAvailable'] ?? false,
      categoriesName: data['categoriesName'] ?? '',
      date: data['date']?? ''
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      // 'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      'categoriesName': categoriesName,
      'date': date
    };
  }
}
