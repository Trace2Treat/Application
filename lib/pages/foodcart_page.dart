import 'package:flutter/material.dart';
import 'foodordersuccess_page.dart';
import '../theme/app_colors.dart';

class FoodCartPage extends StatefulWidget {
  final int counterFromOrder;

  const FoodCartPage({required this.counterFromOrder, Key? key}) : super(key: key);

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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Alamat Pengiriman',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            Text(
              'Griya Cibinong Indah, Kabupaten Bogor, Jawa Barat, Indonesia, 16912',
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 26),
            Text(
              'Pesananmu',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/makanan.png',
                    width: 80.0,
                    height: 80.0,
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
                          fontSize: 16.0,
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
                            'Total Poin: $totalPoin',
                            style: TextStyle(
                              fontSize: 14.0,
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
                margin: EdgeInsets.symmetric(vertical: 10),
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
                          Text('Total poin', style: TextStyle(color: Colors.white)),
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
      ),
    );
  }
}