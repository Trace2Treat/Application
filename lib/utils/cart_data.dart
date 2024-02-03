import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> items = [];

  void addToCart(Map<String, dynamic> foodData) {
    items.add(foodData);
    notifyListeners();
  }
}