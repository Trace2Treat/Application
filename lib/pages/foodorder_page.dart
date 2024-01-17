import 'package:flutter/material.dart';
import 'package:trace2treat/theme/app_colors.dart';
import 'foodcart_page.dart';

class FoodOrderPage extends StatefulWidget {
  const FoodOrderPage({Key? key}) : super(key: key);

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
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.065),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Image.asset(
                  'assets/makanan.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                Positioned(
                  top: 8,
                  left: 8,
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
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Cheese Burger', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('100 Poin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 6),
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
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FoodCartPage(
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
                const SizedBox(width: 6),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}