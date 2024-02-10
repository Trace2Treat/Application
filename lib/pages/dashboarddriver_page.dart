import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'refresh_page.dart';
import 'trashpickuplist_page.dart';
import 'trashdetail_page.dart';
import '../themes/app_colors.dart';
import '../themes/empty_data.dart';
import '../utils/session_manager.dart';
import '../utils/globals.dart';
import '../services/trash_service.dart';

class DashboardDriverPage extends StatefulWidget {
  const DashboardDriverPage({Key? key}) : super(key: key);

  @override
  State<DashboardDriverPage> createState() => _DashboardDriverPageState();
}

class _DashboardDriverPageState extends State<DashboardDriverPage> {
  final TrashService trashController = TrashService();

  String formattedDate(String dateString) {
    DateTime parsedDate = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('EEEE, dd MMMM y', 'id_ID');
    String formatted = formatter.format(parsedDate);

    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/dashboard.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Halo, ${SessionManager().getUserName()}',
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(
                                  Icons.notifications,
                                  color: AppColors.white,
                                ),
                                onPressed: () {
                                  // Notification page
                                },
                              ),
                            ],
                          ),
                      ],
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const TrashPickupListPage()), 
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Lihat Orderan', 
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.white
                              ),
                            )
                          )
                        ),
                      ),
                      Visibility(
                        visible: globalLat.isEmpty && globalLong.isEmpty,
                        child: const SizedBox(height: 10),
                      ),
                      Visibility(
                        visible: globalLat.isEmpty && globalLong.isEmpty,
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const RefreshHomePage()),
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.refresh, color: AppColors.secondary),
                                SizedBox(width: 8), 
                                Text(
                                  'Refresh untuk lokasi Saya',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.secondary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      buildTrashList(),
                    ],
                  )
                )
                ],
              ),
            ),
          ),
        ],
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
      future: trashController.getTrashListForDriver(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        } else if (snapshot.hasError) {
          return const EmptyData();
        } else if (snapshot.data == null) {
          return const EmptyData();
        } else {
          List<Map<String, dynamic>> trashList = snapshot.data!;
            trashList.sort((a, b) {
            double distanceA = getDistanceFromCurrentUser(
                double.parse(a['latitude']),
                double.parse(a['longitude'])
            );
            double distanceB = getDistanceFromCurrentUser(
                double.parse(b['latitude']),
                double.parse(b['longitude'])
            );
            return distanceA.compareTo(distanceB);
          });

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: trashList.length,
            itemBuilder: (context, index) {
              
              double trashLat = double.parse(trashList[index]['latitude']);
              double trashLong = double.parse(trashList[index]['longitude']);
              double distance = getDistanceFromCurrentUser(trashLat, trashLong);

              return Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/trash.png', height: 16, width: 16),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(formattedDate(trashList[index]['created_at']), style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('Nama: ${trashList[index]['user_name']}'),
                          Text('Berat sampah: ${trashList[index]['trash_weight']} kg'),
                          Text('Lokasi: ${trashList[index]['place_name']}', overflow: TextOverflow.ellipsis),
                          Text('Jarak: ${distance.toStringAsFixed(2).toString()} km')
                        ],
                      ),
                    ),
                    IconButton(
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
                      icon: const Icon(Icons.arrow_right_alt_rounded),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}