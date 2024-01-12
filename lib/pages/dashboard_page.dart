import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../theme/app_colors.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String name = 'Kiddovation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/dashboard.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 10, top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, $name',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
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
                ),
                const SizedBox(height: 20),
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                  items: [
                    buildContainer(AppColors.white),
                    buildContainer(AppColors.primary),
                    buildContainer(AppColors.white),
                    buildContainer(AppColors.primary),
                    buildContainer(AppColors.white),
                    buildContainer(AppColors.primary),
                  ],
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
                        ),
                        itemCount: 4, 
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Image.asset(
                                  'assets/defaultmakanan.png',
                                  fit: BoxFit.cover,
                                  width: double.infinity, 
                                  height: 80,
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 23),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Cheese Burger',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Rp 15.000',
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  )
                )
              ],
            ),
        ),
      ),
    );
  }

  Widget buildContainer(Color color) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 5, 
            offset: Offset(0, 2), 
          ),
        ],
      ),
      child: Center(
        child: Text(''),
      ),
    );
  }
}