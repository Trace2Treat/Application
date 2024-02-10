import 'dart:io';
import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'refresh_page.dart';
import 'home_page.dart';
import '../themes/app_colors.dart';
import '../themes/custom_file.dart';
import '../services/trash_service.dart';

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
    const double costPerKilometer = 2000;
    return distance * costPerKilometer;
  }

  CustomFile? pickedFile;
  String attachment = '';
  String file = 'Tambah Foto';
  double uploadProgress = 0;
  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = CustomFile(
          result.files.first.path ?? '', result.files.first.name);
          
    });
  }
  Future<void> uploadFile() async {
    if (pickedFile != null) {
      final path = 'files/${pickedFile!.name}';
      final file = File(pickedFile!.path);

      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putFile(file);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        setState(() {
          uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
        });
      });

      final snapshot = await uploadTask.whenComplete(() {});

      final urlDownload = await snapshot.ref.getDownloadURL();
      setState(() {
        attachment = urlDownload;
      });
      
      print('Direct Image Link: $urlDownload');
    } else {
      print('No file selected');
    }
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
              Visibility(
                visible: status == "Pending" || status == "In Pickup",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  ],
                )
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: status == 'Delivered',
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bukti Penerimaan', 
                      style: TextStyle(
                        fontSize: 14, 
                        fontWeight: FontWeight.bold
                      )
                    ),
                    TextButton(
                      onPressed: () async {
                        await selectFile();
                        await uploadFile();
                      },
                      child: Text(
                        pickedFile == null ? file : pickedFile!.name,
                        style: const TextStyle(color: AppColors.secondary, decoration: TextDecoration.underline),
                      ),
                    ),   
                                      const SizedBox(height: 10),
                                      Visibility(
                                        visible: pickedFile != null,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(5),
                                                  child: LinearProgressIndicator(
                                                    value: uploadProgress,
                                                    minHeight: 10,
                                                    backgroundColor: Colors.grey[300],
                                                    valueColor: const AlwaysStoppedAnimation<Color>(
                                                        AppColors.secondary),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        )
                                      ),
                              ],
                            )
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: status == 'Approved' || status == 'Finished',
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
                    Text(
                        status == 'Finished' ? 'Waiting for approvement' : 'Selesai', 
                        style: const TextStyle(
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
                                  widget.trashDetails['proof_payment'], 
                                  fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      },
                      child: const Text(
                        'Photo',
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

                                              if (attachment.isEmpty) {
                                                AnimatedSnackBar.material(
                                                      'Gagal, foto bukti tidak boleh kosong !',
                                                      type: AnimatedSnackBarType.error,
                                                    ).show(context);
                                                
                                                setState(() {
                                                  controller.isLoading = false;
                                                });

                                              } else {
                                                try {
                                                  await controller.postTrashFinished(id, 'Finished', attachment);
                                                
                                                    AnimatedSnackBar.rectangle(
                                                      'Sukses',
                                                      'Sampah telah diterima Pengepul',
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
            ],
          ),
        ),
      )
    );
  }

  Widget buildDivider() {
    return const Divider(
      height: 0.2,
      color: Colors.grey,
    );
  }
}