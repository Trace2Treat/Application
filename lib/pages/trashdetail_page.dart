import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:intl/intl.dart';
import 'refresh_page.dart';
import '../theme/app_colors.dart';
import '../api/trash_service.dart';

class TrashDetailPage extends StatefulWidget {
  final Map<String, dynamic> trashDetails;
  final String trashDistance;

  const TrashDetailPage({Key? key, required this.trashDetails, required this.trashDistance}) : super(key: key);

  @override
  State<TrashDetailPage> createState() => _TrashDetailPageState();
}

class _TrashDetailPageState extends State<TrashDetailPage> {
  TrashService controller = TrashService();
  double calculateDeliveryCost(double distance) {
    const double costPerKilometer = 5000;
    return distance * costPerKilometer;
  }

  @override
  Widget build(BuildContext context) {
    int id = widget.trashDetails['id'];
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
        title: const Text('Detail Penjemputan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nama', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              username, 
              style: const TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            const Text(
              'Alamat Penjemputan', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              address, 
              style: const TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            const Text(
              'Tipe Sampah', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              type, 
              style: const TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            const Text(
              'Berat Sampah', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              '$weight kg', 
              style: const TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            const Text(
              'Jarak', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              '$distance km dari lokasi saya', 
              style: const TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            const Text(
              'Ongkos Kirim', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              formattedDeliveryCost, 
              style: const TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: status == 'Finished',
              child: Column(
                children: [
                  const Text(
                    'Bukti Penerimaan', 
                    style: TextStyle(
                      fontSize: 14, 
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextButton(
                    onPressed: () {
                      // add file
                    },
                    child: const Text(
                      'Tambah lampiran',
                      style: TextStyle(color: AppColors.secondary, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              )
            ),
            Visibility(
              visible: status == 'Approved',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Status', 
                      style: TextStyle(
                        fontSize: 14, 
                        fontWeight: FontWeight.bold
                      )
                    ),
                  const SizedBox(height: 5),
                  const Text(
                      'Selesai', 
                      style: TextStyle(
                        fontSize: 12, 
                      )
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Bukti Penerimaan', 
                    style: TextStyle(
                      fontSize: 14, 
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Image.network(
                                widget.trashDetails['thumb'], 
                                fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Lihat lampiran',
                      style: TextStyle(color: AppColors.secondary, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              )
            ),
            const Spacer(),
            Visibility(
              visible: status == 'Pending',
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    controller.isLoading = true;
                  });

                  try {
                      await controller.postTrashUpdateStatus(id, 'In Pickup');
                    
                        AnimatedSnackBar.rectangle(
                          'Sukses',
                          'Anda akan menjemput sampah',
                          type: AnimatedSnackBarType.success,
                          brightness: Brightness.light,
                        ).show(
                          context,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RefreshHomePage()), 
                        );

                  } catch (e) {
                      print('Error during posting: $e');
                      AnimatedSnackBar.material(
                          'Gagal, coba lagi !',
                          type: AnimatedSnackBarType.error,
                        ).show(context);

                      setState(() {
                        controller.isLoading = false;
                      });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
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
                        controller.isLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                          )
                        : const Text('Jemput Sampah', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ),
              ),
            ),
            Visibility(
              visible: status == 'In Pickup',
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    controller.isLoading = true;
                  });

                  try {
                      await controller.postTrashUpdateStatus(id, 'Received');
                    
                        AnimatedSnackBar.rectangle(
                          'Sukses',
                          'Sampah telah diterima',
                          type: AnimatedSnackBarType.success,
                          brightness: Brightness.light,
                        ).show(
                          context,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RefreshHomePage()), 
                        );

                  } catch (e) {
                      print('Error during posting: $e');
                      AnimatedSnackBar.material(
                          'Gagal, coba lagi !',
                          type: AnimatedSnackBarType.error,
                        ).show(context);

                      setState(() {
                        controller.isLoading = false;
                      });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
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
                        controller.isLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                          )
                        : const Text('Diterima', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ),
              ),
            ),
            Visibility(
              visible: status == 'Received',
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    controller.isLoading = true;
                  });

                  try {
                      await controller.postTrashUpdateStatus(id, 'Delivered');
                    
                        AnimatedSnackBar.rectangle(
                          'Sukses',
                          'Sampah akan dikirim ke Pengepul',
                          type: AnimatedSnackBarType.success,
                          brightness: Brightness.light,
                        ).show(
                          context,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RefreshHomePage()), 
                        );

                  } catch (e) {
                      print('Error during posting: $e');
                      AnimatedSnackBar.material(
                          'Gagal, coba lagi !',
                          type: AnimatedSnackBarType.error,
                        ).show(context);

                      setState(() {
                        controller.isLoading = false;
                      });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
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
                        controller.isLoading 
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                          )
                        : const Text('Kirim ke Pengepul', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ),
              ),
            ),
            Visibility(
              visible: status == 'Delivered',
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    controller.isLoading = true;
                  });

                  try {
                      await controller.postTrashUpdateStatus(id, 'Finished');
                    
                        AnimatedSnackBar.rectangle(
                          'Sukses',
                          'Sampah telah diterima oleh Pengepul',
                          type: AnimatedSnackBarType.success,
                          brightness: Brightness.light,
                        ).show(
                          context,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RefreshHomePage()), 
                        );

                  } catch (e) {
                      print('Error during posting: $e');
                      AnimatedSnackBar.material(
                          'Gagal, coba lagi !',
                          type: AnimatedSnackBarType.error,
                        ).show(context);

                      setState(() {
                        controller.isLoading = false;
                      });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
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
                        controller.isLoading 
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                          )
                        : const Text('Diterima oleh Pengepul', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                  // send form attachment
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
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