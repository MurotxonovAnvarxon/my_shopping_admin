import '../../product_data/product_data.dart';

class SellingProduct {
  final List<Product> products;
  final String date;
  final String phone;

  SellingProduct({
    required this.products,
    required this.date,
    required this.phone,
  });

  factory SellingProduct.fromJson(Map<String, dynamic> json) {
    List<dynamic> productListData = json['products'];
    List<Product> productList = productListData
        .map((productData) => Product.fromFirestore(productData))
        .toList();
    return SellingProduct(
      products: productList,
      date: json['date'] ?? '',
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'products': products.map((product) => product.toMap()).toList(),
      'date': date,
      'phone': phone,
    };
  }
}
