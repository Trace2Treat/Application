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
  String selectedStatus = 'All';

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

  void filterListByStatus(String status) {
    String selectedStatusText;

    switch (status) {
      case 'Semua':
        selectedStatusText = 'Semua';
        break;
      case 'pending':
        selectedStatusText = 'Order masuk';
        break;
      case 'preparing':
        selectedStatusText = 'Sedang disiapkan';
        break;
      case 'prepared':
        selectedStatusText = 'Pesanan jadi';
        break;
      default:
        selectedStatusText = 'Semua';
        break;
    }

    setState(() {
      selectedStatus = selectedStatusText;
      filteredList = transactionList
          .where((transaction) => status == 'Semua' || transaction['status'] == status)
          .toList();
    });
  }

  void showStatusDropdown(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(500, 1000, 0, 0),
      items: ['Semua', 'pending', 'preparing', 'prepared']
        .map<PopupMenuEntry<String>>(
          (String value) => PopupMenuItem<String>(
            value: value,
            child: Text(
              getStatusDropdownText(value),
            ),
          ),
        )
        .toList(),
    ).then((value) {
      if (value != null) {
        filterListByStatus(value);
      }
    });
  }

  String getStatusDropdownText(String status) {
    switch (status) {
      case 'Semua':
        return 'Semua';
      case 'pending':
        return 'Order masuk';
      case 'preparing':
        return 'Sedang disiapkan';
      case 'prepared':
        return 'Pesanan jadi';
      default:
        return 'Semua';
    }
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
      child: Scaffold(
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
                        decoration: const InputDecoration(
                          labelText: 'Caru...',
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
                                      onTap: () async {
                                        try {
                                          await controller.transactionUpdateStatus(transaction['id'], 'preparing');

                                          fetchData();
                                        } catch (error) {
                                          print('Error accepting transaction: $error');
                                        }
                                      },
                                      child: SizedBox(
                                        height: 40,
                                        width: 100,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
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
                                              ]
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        try {
                                          await controller.transactionUpdateStatus(transaction['id'], 'failed');

                                          fetchData();
                                        } catch (error) {
                                          print('Error accepting transaction: $error');
                                        }
                                      },
                                      child: SizedBox(
                                        height: 40,
                                        width: 100,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
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
                                            ]
                                          ),
                                        ),
                                      )
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
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
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showStatusDropdown(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.filter_alt_rounded,
                        color: Colors.white,
                      ),
                    )
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ManagementHistoryPage()), 
                        );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.history,
                        color: Colors.white,
                      ),
                    )
                  )
                ],
              )
            ),
          ]
        )
      )
    );
  }
}