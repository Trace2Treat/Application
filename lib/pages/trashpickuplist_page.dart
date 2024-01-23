import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'trashdetail_page.dart';
import '../themes/app_colors.dart';
import '../themes/empty_data.dart';
import '../utils/globals.dart';
import '../services/trash_service.dart';

class TrashPickupListPage extends StatefulWidget {
  const TrashPickupListPage({Key? key}) : super(key: key);

  @override
  State<TrashPickupListPage> createState() => _TrashPickupListPageState();
}

class _TrashPickupListPageState extends State<TrashPickupListPage> {
  final TrashService trashController = TrashService();

  String formattedDate(String dateString) {
    DateTime parsedDate = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('EEEE, dd MMMM y', 'id_ID');
    String formatted = formatter.format(parsedDate);

    return formatted;
  }
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
  }

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
        title: const Text('Daftar Orderan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildTrashList(),
              ],
            ),
      ),
    );
  }

  double calculateDistance(double startLat, double startLong, double endLat, double endLong) {
    const double radius = 6371.0; 

    double toRadians(double degree) {
      return degree * (pi / 180.0);
    }

    double dLat = toRadians(endLat - startLat);
    double dLon = toRadians(endLong - startLong);
    double a = sin(dLat / 2) * sin(dLat / 2) + cos(toRadians(startLat)) * cos(toRadians(endLat)) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return radius * c;
  }

  double getDistanceFromCurrentUser(double trashLat, double trashLong) {
    try {
      double userLat = double.parse(globalLat);
      double userLong = double.parse(globalLong);

      return calculateDistance(userLat, userLong, trashLat, trashLong);
    } catch (e) {
      print('Error parsing latitude or longitude: $e');
      return 0.0; 
    }
  }

  Widget buildTrashList() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: trashController.getTrashListOngoing(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        } else if (snapshot.hasError) {
          return const EmptyData();
        } else if (snapshot.data == null) {
          return const EmptyData();
        } else {
          List<Map<String, dynamic>> trashList = snapshot.data!;
          trashList.sort((a, b) => b['id'].compareTo(a['id']));

          return Expanded(
            child: ListView.builder(
              itemCount: trashList.length,
              itemBuilder: (context, index) {
                double trashLat = double.parse(trashList[index]['latitude']);
                double trashLong = double.parse(trashList[index]['longitude']);
                double distance = getDistanceFromCurrentUser(trashLat, trashLong);

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(children: [
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text(trashList[index]['status'], style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                                  Text(formattedDate(trashList[index]['created_at']))
                                ]),
                                Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          backgroundColor: Colors.white,
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding: const EdgeInsets.all(30),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text('Order Detail', style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text('Id'),
                                                      Text('#${trashList[index]['id'].toString()}'),
                                                    ]
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text('Status'),
                                                      Text(trashList[index]['status']),
                                                    ]
                                                  ),
                                                  const Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('Delivery Payment'),
                                                      Text('Cash'),
                                                    ]
                                                  ),
                                                  const SizedBox(height: 18),
                                                  const Text('Pickup Address', style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
                                                  const SizedBox(height: 8),
                                                  Text(trashList[index]['place_name']),
                                                  const SizedBox(height: 18),
                                                  const Text('User Detail', style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
                                                  const SizedBox(height: 8),
                                                  Text(trashList[index]['user_name']),
                                                  Text(trashList[index]['phone']),
                                                  Text('Jarak: ${distance.toStringAsFixed(2).toString()} km'),
                                                  Visibility(
                                                    visible: trashList[index]['status'] == 'Approved' || trashList[index]['status'] == 'Finished',
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext context) {
                                                                return AlertDialog(
                                                                  content: Image.network(
                                                                      trashList[index]['thumb'], 
                                                                      fit: BoxFit.cover,
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: const Text(
                                                            'Lihat bukti',
                                                            style: TextStyle(color: AppColors.secondary, decoration: TextDecoration.underline),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Center(
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        primary: AppColors.secondary,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        'Back',
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        );
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColors.secondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Detail',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ]),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: AppColors.secondary,
                                    backgroundImage: NetworkImage(trashList[index]['avatar']),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          trashList[index]['user_name'],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          trashList[index]['phone'],
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Visibility(
                                visible: trashList[index]['status'] != 'Approved',
                                child: Row(
                                  children: [
                                    Expanded(
                                      child:ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TrashDetailPage(
                                              trashDetails: trashList[index], 
                                              trashDistance: distance.toStringAsFixed(2),
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text(
                                        'Update Status',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            )
                          ]
                        )
                      )
                    );
                  },
            )
          );
        }
      },
    );
  }
}