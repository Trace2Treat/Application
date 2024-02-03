import 'package:flutter/material.dart';
import 'foodordersuccess_page.dart';
import '../themes/app_colors.dart';
import '../utils/globals.dart';

class FoodCartPage extends StatefulWidget {
  //final String restaurantId;
  final int counterFromOrder;

  const FoodCartPage({
    required this.counterFromOrder, 
    //required this.restaurantId, 
    Key? key}) : super(key: key);

  @override
  State<FoodCartPage> createState() => _FoodCartPageState();
}

class _FoodCartPageState extends State<FoodCartPage> {
  late int counter;
  late int totalPoin;

  @override
  void initState() {
    super.initState();
    counter = widget.counterFromOrder;
    totalPoin = 100 * counter;
  }

  void incrementCounter() {
    setState(() {
      counter++;
      totalPoin = 100 * counter;
    });
  }

  void decrementCounter() {
    if (counter > 1) {
      setState(() {
        counter--;
        totalPoin = 100 * counter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Keranjang'),
        centerTitle: true,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Restoran',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                    ),
                    Divider(),
                    Text(
                                '$grestaurantName ($grestaurantPhone)',
                                style: TextStyle(fontSize: 14),
                    ),
                    Text(
                                grestaurantAddress,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                ]
              )
            ),
            Container(
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Pesananmu',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/makanan.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cheese Burger',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
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
                                  ],
                                ),
                                Text(
                                  'Total Koin: $totalPoin',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]
              )
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => const OrderSuccessPage()
                  ), 
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Koin', style: TextStyle(color: Colors.white)),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/point.png', height: 16, width: 16, color: Colors.white),
                                          const SizedBox(width: 5),
                                          Text(
                                            '$totalPoin',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white
                                            ),
                                          )
                            ]
                          )
                        ],
                      ),
                      Text('Tukar ($counter)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ),
            )
          ],
        ),
    );
  }
}