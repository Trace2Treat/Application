import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';

class TrashDetailPage extends StatefulWidget {
  final Map<String, dynamic> trashDetails;
  final String trashDistance;

  const TrashDetailPage({Key? key, required this.trashDetails, required this.trashDistance}) : super(key: key);

  @override
  State<TrashDetailPage> createState() => _TrashDetailPageState();
}

class _TrashDetailPageState extends State<TrashDetailPage> {
  double calculateDeliveryCost(double distance) {
    const double costPerKilometer = 5000;
    return distance * costPerKilometer;
  }

  @override
  Widget build(BuildContext context) {
    String username = widget.trashDetails['user_name'];
    String type = widget.trashDetails['trash_type'];
    String weight = widget.trashDetails['trash_weight'];
    String address = widget.trashDetails['place_name'];
    String distance = widget.trashDistance;
    double deliveryCost = (calculateDeliveryCost(double.parse(distance))/1000).round() * 1000;
    String formattedDeliveryCost = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ').format(deliveryCost);
    String status = widget.trashDetails['status'];
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Penjemputan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              username, 
              style: TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            Text(
              'Alamat Penjemputan', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              address, 
              style: TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            Text(
              'Tipe Sampah', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              type, 
              style: TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            Text(
              'Berat Sampah', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              '$weight kg', 
              style: TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            Text(
              'Jarak', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              '$distance km dari lokasi saya', 
              style: TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            Text(
              'Ongkos Kirim', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              formattedDeliveryCost, 
              style: TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: status == 'Finished',
              child: Column(
                children: [
                  Text(
                    'Bukti Penerimaan', 
                    style: TextStyle(
                      fontSize: 14, 
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextButton(
                                      onPressed: () {
                                        // post attachment
                                      },
                                      child: Text(
                                        'Tambah lampiran',
                                          style: const TextStyle(color: AppColors.secondary, decoration: TextDecoration.underline),
                                      ),
                  ),
                ],
              )
            ),
            Visibility(
              visible: status == 'Approved',
              child: Column(
                children: [
                    Text(
                      'Status', 
                      style: TextStyle(
                        fontSize: 14, 
                        fontWeight: FontWeight.bold
                      )
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Selesai', 
                      style: TextStyle(
                        fontSize: 12, 
                      )
                    ),
                    const SizedBox(height: 10),
                  Text(
                    'Bukti Penerimaan', 
                    style: TextStyle(
                      fontSize: 14, 
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextButton(
                                      onPressed: () {
                                        // post attachment
                                      },
                                      child: Text(
                                        'Lihat lampiran',
                                          style: const TextStyle(color: AppColors.secondary, decoration: TextDecoration.underline),
                                      ),
                  ),
                ],
              )
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                // change status
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Jemput Sampah', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ),
            ),
            Visibility(
              visible: status == 'Pending',
              child: GestureDetector(
                onTap: () {
                  // change status
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Jemput Sampah', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ),
              ),
            ),
            Visibility(
              visible: status == 'In Pickup',
              child: GestureDetector(
                onTap: () {
                  // change status
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Diterima', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ),
              ),
            ),
            Visibility(
              visible: status == 'Received',
              child: GestureDetector(
                onTap: () {
                  // change status
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Kirim ke Pengepul', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ),
              ),
            ),
            Visibility(
              visible: status == 'Delivered',
              child: GestureDetector(
                onTap: () {
                  // change status
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Diterima oleh Pengepul', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ),
              ),
            ),
            Visibility(
              visible: status == 'Finished',
              child: GestureDetector(
                onTap: () {
                  // change status
                  // send form attachment
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Selesai', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDivider() {
    return const Divider(
      height: 0.2,
      color: Colors.grey,
    );
  }
}