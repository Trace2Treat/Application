import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class FoodCartPage extends StatefulWidget {
  const FoodCartPage({Key? key}) : super(key: key);

  @override
  State<FoodCartPage> createState() => _FoodCartPageState();
}

class _FoodCartPageState extends State<FoodCartPage> {

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
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  // minus logic
                                },
                              ),
                              SizedBox(width: 8),
                              Text('1'),
                              SizedBox(width: 8),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  // add logic
                                },
                              ),
                            ],
                          ),
                          Text(
                            'Total Poin: 100',
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
            Container(
              width: double.infinity,
              color: AppColors.primary,
              child: Padding(
                padding: EdgeInsets.all(16),
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
                                          '100',
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
                    Text('Tukar (1)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}