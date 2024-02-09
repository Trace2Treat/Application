import 'package:flutter/material.dart';
import 'package:trace2treat/pages/managementdetail_page.dart';
import 'home_page.dart';
import 'managementhistory_page.dart';
import '../themes/app_colors.dart';
import '../themes/empty_data.dart';
import '../services/transaction_service.dart';

class ManagementOrderPage extends StatefulWidget {
  const ManagementOrderPage({Key? key}) : super(key: key);

  @override
  State<ManagementOrderPage> createState() => _ManagementOrderPageState();
}

class _ManagementOrderPageState extends State<ManagementOrderPage> {
  final TransactionService controller = TransactionService();
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> transactionList = [];
  List<Map<String, dynamic>> filteredList = [];
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  Future<void> fetchData() async {
    try {
      List<Map<String, dynamic>> transactions = await controller.getTransactionList();
      setState(() {
        transactionList = transactions;
        filteredList = transactions;
      });
    } catch (e) {
      print('Error fetching transaction list: $e');
    }
  }

  void filterList(String query) {
    setState(() {
      filteredList = transactionList.where((transaction) {
        final userName = transaction['userName'].toString().toLowerCase();
        return userName.contains(query.toLowerCase());
      }).toList();
    });
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
              MaterialPageRoute(builder: (context) => const HomePage()), 
            );
          },
        ),
        centerTitle: true,
        title: const Text('Pesanan'),
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
                TextField(
                  controller: searchController,
                  onChanged: (query) {
                    filterList(query);
                  },
                  decoration: InputDecoration(
                    labelText: 'Search customer name...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {

                    Map<String, dynamic> transaction = filteredList[index];
                    double price = (double.parse(transaction['total'] ?? 0));
                    String formattedPrice = price.toStringAsFixed(0);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ManagementDetailPage(transaction: transaction),
                          ),
                        );
                      },
                      child: Column(
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
                            Visibility(
                              visible: transaction['status'] == 'pending',
                              child: Row(
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
                            ),
                            SizedBox(height: 20),
                          ],
                        )
                      );
                    },
                  ),
                ),
              ]
            ),
          ),
          Positioned(
            right: 26,
            bottom: 36,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ManagementHistoryPage()), 
                  );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.history,
                  color: Colors.white,
                ),
              )
            )
          ),
        ]
      )
    );
  }
}