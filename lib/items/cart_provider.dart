import 'package:flutter/material.dart';
import 'package:my_shopping_admin/data/servise.dart';
import 'package:my_shopping_admin/product_data/product_data.dart';
import 'package:my_shopping_admin/service.dart';

class CartProvider extends ChangeNotifier {

  List<Product>  data =ProductService.productList;

  final List<Product> _cartedItems = [];

  List<Product> get cartedItems => _cartedItems;

  set addToCart(Product itemModel) {
    if (_cartedItems.contains(itemModel)) {
      return;
    }
    _cartedItems.add(itemModel);
    notifyListeners();
  }

  set removeFromCart(Product item) {
    _cartedItems.remove(item);
    notifyListeners();
  }

  double get total {
    double t = 0;

    for (var e in _cartedItems) {
      t += double.parse(e.price);
    }

    return t;
  }
}
