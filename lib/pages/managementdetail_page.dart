import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'managementorder_page.dart';
import '../themes/app_colors.dart';
import '../services/transaction_service.dart';

class ManagementDetailPage extends StatefulWidget {
  final Map<String, dynamic> transaction;

  const ManagementDetailPage({required this.transaction, Key? key}) : super(key: key);

  @override
  State<ManagementDetailPage> createState() => _ManagementDetailPageState();
}

class _ManagementDetailPageState extends State<ManagementDetailPage> {
  final TransactionService controller = TransactionService();
  late Map<String, dynamic> transaction;
  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year} "
        "[${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}]";
    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    transaction = widget.transaction;
  }

  @override
  Widget build(BuildContext context) {
    double price = (double.parse(transaction['total'] ?? 0));
    String formattedPrice = price.toStringAsFixed(0);

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ManagementOrderPage()),
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
                MaterialPageRoute(builder: (context) => const ManagementOrderPage()), 
              );
            },
          ),
          centerTitle: true,
          title: const Text('Detail Pesanan'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dipesan pada ${formatDateTime(transaction['created_at'])}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Customer', 
                style: TextStyle(
                  fontSize: 14, 
                  fontWeight: FontWeight.bold
                )
              ),
              const SizedBox(height: 5),
              Text(
                transaction['userName'], 
                style: const TextStyle(
                  fontSize: 12, 
                )
              ),
              const SizedBox(height: 10),
              const Text(
                'Nomor Telepon', 
                style: TextStyle(
                  fontSize: 14, 
                  fontWeight: FontWeight.bold
                )
              ),
              const SizedBox(height: 5),
              Text(
                transaction['userPhone'], 
                style: const TextStyle(
                  fontSize: 12, 
                )
              ),
              const SizedBox(height: 10),
              const Text(
                'Total', 
                style: TextStyle(
                  fontSize: 14, 
                  fontWeight: FontWeight.bold
                )
              ),
              const SizedBox(height: 5),
              Text(
                '$formattedPrice koin', 
                style: const TextStyle(
                  fontSize: 12, 
                )
              ),
              const SizedBox(height: 10),
              buildFoodItemsList(transaction['items']),
              const SizedBox(height: 10),
              Visibility(
                  visible: transaction['status'] == 'pending',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          try {
                            await controller.transactionUpdateStatus(transaction['id'], 'preparing');

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManagementOrderPage()),
                            );
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

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ManagementOrderPage()
                                ),
                              );
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
                      )
                    ],
                  ),
              ),
              Visibility(
                  visible: transaction['status'] == 'preparing',
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await controller.transactionUpdateStatus(transaction['id'], 'prepared');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManagementOrderPage()
                          ),
                        );
                      } catch (error) {
                        print('Error accepting transaction: $error');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      primary: AppColors.primary,
                    ),
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 50),
                      alignment: Alignment.center,
                      child: const Text(
                        'Pesanan telah jadi',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
              ),
              Visibility(
                visible: transaction['status'] == 'prepared',
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        List<int> qrCodeBase64 = await controller.getQrCode(transaction['transaction_code']);

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('QR Pembayaran'),
                              content: Image.memory(Uint8List.fromList(qrCodeBase64)),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        'QR Pembayaran',
                        style: TextStyle(color: AppColors.secondary, decoration: TextDecoration.underline),
                      ),
                    ) 
                  ],
                )
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget buildFoodItemsList(List<Map<String, dynamic>> items) {
    return Container(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey, 
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          return ListTile(
            leading: Image.network(
              item['food']['thumb'],
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
            title: Text(item['food']['name']),
            subtitle: Text('Jumlah: ${item['qty']}'),
          );
        }).toList(),
      )
    );
  }
}