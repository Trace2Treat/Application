import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'foodorder_page.dart';
import 'managementorder_page.dart';
import '../theme/app_colors.dart';
import '../utils/session_manager.dart';
import '../api/food_service.dart';

class DashboardUmkmPage extends StatefulWidget {
  const DashboardUmkmPage({Key? key}) : super(key: key);

  @override
  State<DashboardUmkmPage> createState() => _DashboardUmkmPageState();
}

class _DashboardUmkmPageState extends State<DashboardUmkmPage> {
  final CarouselController controller = CarouselController();
  final FoodService foodController = FoodService();
  int currentIndex = 0;
  List<String> imageAssets = [
    'assets/banner.png',
    'assets/banner.png',
    'assets/banner.png',
  ];
  List<Map<String, dynamic>> foodList = [];

  @override
  void initState() {
    super.initState();
    fetchFoodList();
  }

  Future<void> fetchFoodList() async {
    try {
      final List<Map<String, dynamic>> foods = await foodController.getFoodList();
      setState(() {
        foodList = foods;
      });
    } catch (e) {
      print('Error fetching food list: $e');
    }
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
                                          MaterialPageRoute(builder: (context) => const ManagementOrderPage()), 
                                        );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.secondary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    'Lihat Pesanan', 
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white
                                    ),
                                  )
                                )
                              ),
                            ),
                    ],
                  )
                ),
                const SizedBox(height: 10),
                CarouselSlider(
                  items: imageAssets.map((asset) {
                    return ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              asset, 
                              fit: BoxFit.cover,
                            ),
                          );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  carouselController: controller,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => buildDot(index),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Makanan Tersedia', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          TextButton(onPressed: (){}, child: Text('Lihat Semua', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.secondary)))
                        ]
                      ),
                      const SizedBox(height: 10),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: 0.9, 
                        ),
                        itemCount: foodList.length,
                        itemBuilder: (context, index) {
                          return buildFoodCard(foodList[index]);
                        },
                      ),
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

  Widget buildDot(int index) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == index ? AppColors.primary : Colors.grey,
      ),
    );
  }

  Widget buildFoodCard(Map<String, dynamic> food) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FoodOrderPage()), 
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
              'assets/makanan.png', 
              // child: Image.network(
              //   food['thumb'] ?? '-',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 90,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food['name'] ?? '-',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rp ${food['price'] ?? 0}',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [ 
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Tersedia',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}