import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> items = [];

  void addToCart(Map<String, dynamic> foodData) {
    items.add(foodData);
    notifyListeners();
  }

  List<Map<String, dynamic>> formatItemsForSending() {
    List<Map<String, dynamic>> formattedItems = [];
    
    for (var item in items) {
      Map<String, dynamic> formattedItem = {
        '"food_id"': item['food_id'],
        '"qty"': item['qty'],
      };
      formattedItems.add(formattedItem);
    }
    
    return formattedItems;
  }
}