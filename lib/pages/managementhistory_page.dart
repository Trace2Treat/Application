import 'package:flutter/material.dart';
import 'managementorder_page.dart';
import '../themes/empty_data.dart';
import '../services/transaction_service.dart';

class ManagementHistoryPage extends StatefulWidget {
  const ManagementHistoryPage({Key? key}) : super(key: key);

  @override
  State<ManagementHistoryPage> createState() => _ManagementHistoryPageState();
}

class _ManagementHistoryPageState extends State<ManagementHistoryPage> {
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
      List<Map<String, dynamic>> transactions = await controller.getHistoryList();
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ManagementOrderPage()), 
            );
          },
        ),
        centerTitle: true,
        title: const Text('Riwayat Pesanan'),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          transactionList.isEmpty ? const EmptyData()
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
                        ],
                      );
                    },
                  ),
                ),
              ]
            ),
          ),
        ]
      )
    );
  }
}