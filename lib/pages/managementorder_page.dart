import 'package:flutter/material.dart';
import 'package:bottom_navigation_view/bottom_navigation_view.dart';
import '../themes/app_colors.dart';
import '../services/transaction_service.dart';

class ManagementOrderPage extends StatefulWidget {
  const ManagementOrderPage({Key? key}) : super(key: key);

  @override
  State<ManagementOrderPage> createState() => _ManagementOrderPageState();
}

class _ManagementOrderPageState extends State<ManagementOrderPage> {
  final TransactionService controller = TransactionService();
  List<Map<String, dynamic>> transactionList = [];
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      List<Map<String, dynamic>> transactions = await controller.getTransactionList();
      setState(() {
        transactionList = transactions;
      });
    } catch (e) {
      print('Error fetching transaction list: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan'),
      ),
      body: transactionList.isEmpty ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
        : Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: transactionList.length,
                    itemBuilder: (context, index) {

                    Map<String, dynamic> transaction = transactionList[index];
                    double price = (double.parse(transaction['total'] ?? 0));
                    String formattedPrice = price.toStringAsFixed(0);

                    return Column(
                      children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  transaction['items'][0]['food']['thumb'],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('#${transaction['transaction_code']}'),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          transaction['userName'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          ' (${transaction['userPhone']})',
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        
                                      ]
                                    ),
                                    Text(
                                      'Total: $formattedPrice',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  // change status
                                },
                                child: SizedBox(
                                height: 40,
                                width: 100,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  color: AppColors.primary,
                                  child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 10),
                                        Text(
                                          'Terima',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 10),
                                      ]),
                                ),
                              ),
                              ),
                              SizedBox(
                                height: 40,
                                width: 100,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  color: const Color(0xFFBC5757),
                                  child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 10),
                                        Text(
                                          'Tolak',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 10),
                                      ]),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                },
              ),
            )
          ]
        )
      )
    );
  }
}