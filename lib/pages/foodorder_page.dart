import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'foodcart_page.dart';
import '../utils/cart_data.dart';
import '../themes/app_colors.dart';

class FoodOrderPage extends StatefulWidget {
  final int foodId;
  final String foodName;
  final String formattedPrice;
  final String foodImage;
  final int restaurantId;
  // final int stock;

  const FoodOrderPage({
    required this.foodId,
    required this.foodName,
    required this.formattedPrice,
    required this.foodImage,
    required this.restaurantId,
    // required this.stock,
    Key? key}) : super(key: key);

  @override
  State<FoodOrderPage> createState() => _FoodOrderPageState();
}

class _FoodOrderPageState extends State<FoodOrderPage> {
  int counter = 1;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    if (counter > 1) {
      setState(() {
        counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Image.network(
                    widget.foodImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250,
                  ),
                  Positioned(
                    top: 36,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                color: AppColors.primary,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.foodName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text(widget.formattedPrice, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        decrementCounter(); 
                      },
                    ),
                    const SizedBox(width: 8),
                    Text('$counter'), 
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        incrementCounter(); 
                      },
                    ),
                  ]
                ),
                ElevatedButton(
                  onPressed: () {
                    final cartProvider = Provider.of<CartProvider>(context, listen: false);

                    final foodData = {
                      "food_id": widget.foodId,
                      "qty": counter,
                      "thumb": widget.foodImage,
                      "name": widget.foodName,
                      "price": widget.formattedPrice,
                      "totalPoin": int.parse(widget.formattedPrice) * counter
                    };

                    cartProvider.addToCart(foodData);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FoodCartPage(
                        restaurantId: widget.restaurantId,
                        counterFromOrder: counter,
                      )), 
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.shopping_cart),
                      SizedBox(width: 8),
                      Text('Tambah ke Keranjang'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
