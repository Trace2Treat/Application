import 'package:flutter/material.dart';
import 'refresh_page.dart';
import 'foodform_page.dart';
import 'home_page.dart';
import '../services/food_service.dart';
import '../themes/app_colors.dart';
import '../themes/empty_data.dart';
import '../utils/session_manager.dart';

class FoodListPage extends StatefulWidget {
  const FoodListPage({Key? key}) : super(key: key);

  @override
  State<FoodListPage> createState() => _FoodListPagePageState();
}

class _FoodListPagePageState extends State<FoodListPage> {
  final FoodService controller = FoodService();

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
          title: const Text('Daftar Menu'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                  onPressed: () {
                    if (SessionManager().getRestaurantName()!.isNotEmpty){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FoodFormPage()), 
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RefreshRegistForm()), 
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    primary: Colors.transparent,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(56),
                    ),
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 36, minWidth: 88),
                      alignment: Alignment.center,
                      child: const Text(
                        'Tambah Menu',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: controller.getFoodListRestaurant(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const EmptyData();
                } else if (snapshot.data == null) {
                  return const EmptyData();
                } else {
                  List<Map<String, dynamic>> foodList = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: foodList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white, 
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/trash.png', height: 16, width: 16),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(foodList[index]['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text('Deskripsi: ${foodList[index]['description']}'),
                                Text('Harga: ${foodList[index]['price'] ?? 0}'),
                              ],
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => FoodDetailPage(
                                //       selectedData: foodList[index],
                                //     ),
                                //   ),
                                // );
                              }, 
                              icon: const Icon(Icons.arrow_right_alt_rounded)
                            )
                          ]
                        )
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      )
    );
  }
}