import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'foodordersuccess_page.dart';
import 'restaurantmenu_page.dart';
import '../themes/app_colors.dart';
import '../utils/globals.dart';
import '../utils/cart_data.dart';
import '../services/transaction_service.dart';

class FoodCartPage extends StatefulWidget {
  final int restaurantId;

  const FoodCartPage({
    required this.restaurantId, 
    Key? key}) : super(key: key);

  @override
  State<FoodCartPage> createState() => _FoodCartPageState();
}

class _FoodCartPageState extends State<FoodCartPage> {
  final CartProvider cartProvider = CartProvider();
  final TransactionService transactionService = TransactionService();
  late int counter;
  int totalPoin = 0;

  int calculateTotalPoin(int quantity, String price) {
    int numericPrice = int.tryParse(price) ?? 0;
    
    return quantity * numericPrice;
  }

  @override
  void initState() {
    super.initState();
    updateTotalPoin();
  }

  void updateTotalPoin() {
    int finalTotalPoin = 0;
    int finalCounter = 0;

    final cartProvider = context.read<CartProvider>();

    for (var item in cartProvider.items) {
      finalTotalPoin += int.tryParse(item['totalPoin'].toString()) ?? 0;
    }

    setState(() {
      finalCounter = cartProvider.items.length;
      counter = finalCounter;
      totalPoin = finalTotalPoin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        return false;
      },
      child:  Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          title: Text('Keranjang'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
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
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pesananmu',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RestoMenuPage(
                                      restaurantId: widget.restaurantId,
                                    ),
                                  ),
                                );
                              },
                              child: Text('+ Tambah', style: TextStyle(color: AppColors.primary)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer<CartProvider>(
                            builder: (context, cartProvider, child) {
                              int finalTotalPoin = 0;

                              return Column(
                                children: cartProvider.items.map((item) {
                                  finalTotalPoin += int.tryParse(item['totalPoin'].toString()) ?? 0;
                                  totalPoin = finalTotalPoin;

                                  List<Map<String, dynamic>> formattedItems = cartProvider.formatItemsForSending();

                                  return Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          item['thumb'],
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
                                              item['name'],
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
                                                        setState(() {
                                                          if (item['qty'] > 1) {
                                                            item['qty']--;
                                                            item['totalPoin'] = calculateTotalPoin(item['qty'], item['price']);
                                                            updateTotalPoin();
                                                          } else {
                                                            cartProvider.items.remove(item);
                                                            updateTotalPoin();
                                                          }
                                                        });
                                                        print('List panjang: ${cartProvider.items}');
                                                        print('List pengiriman ke API: $formattedItems');
                                                      },
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text('${item['qty']}'),
                                                    const SizedBox(width: 8),
                                                    IconButton(
                                                      icon: const Icon(Icons.add),
                                                      onPressed: () {
                                                        setState(() {
                                                          item['qty']++;
                                                          item['totalPoin'] = calculateTotalPoin(item['qty'], item['price']);
                                                          updateTotalPoin();
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'Total Koin: ${item['totalPoin']}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      ),
                                      
                                    ],
                                  );
                                }).toList() 
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                try {
                  final purchaseList = cartProvider.formatItemsForSending();
                  final restoId = widget.restaurantId.toString();

                  await transactionService.purchaseFood(restoId, purchaseList);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderSuccessPage(),
                    ),
                  );
                } catch (error) {
                  print('Error occurred while purchasing: $error');
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text('Tukar ($counter)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}