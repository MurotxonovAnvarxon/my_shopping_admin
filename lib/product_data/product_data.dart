import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id; // Unique document ID in Firestore
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isAvailable; // Indicates product availability

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isAvailable,
  });

  // Convert Product object to a map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      'createdAt': Timestamp.now(),
    };
  }
}
