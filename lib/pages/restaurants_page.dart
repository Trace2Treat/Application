import 'package:flutter/material.dart';
import 'restaurantmenu_page.dart';
import 'home_page.dart';
import 'foodcart_page.dart';
import '../services/restaurant_service.dart';
import '../themes/app_colors.dart';
import '../themes/empty_data.dart';
import '../utils/globals.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  State<RestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  final RestaurantService controller = RestaurantService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text('Resto'),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          ListView(
            children: [
              FutureBuilder<List<Map<String, dynamic>>>(
                future: controller.getRestaurantList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const EmptyData();
                  } else if (snapshot.data == null) {
                    return const EmptyData();
                  } else {
                    List<Map<String, dynamic>> restaurantList = snapshot.data!;
                    restaurantList.sort((a, b) => a['name'].compareTo(b['name']));

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: restaurantList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            if (index == 0) const SizedBox(height: 12),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.grey, 
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.network(
                                      restaurantList[index]['logo'],
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(restaurantList[index]['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text(restaurantList[index]['description'], style: TextStyle(fontWeight: FontWeight.normal), overflow: TextOverflow.ellipsis),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        grestaurantAddress = restaurantList[index]['address'];
                                        grestaurantName = restaurantList[index]['name'];
                                        grestaurantPhone = restaurantList[index]['phone'];
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RestoMenuPage(
                                            restaurantId: restaurantList[index]['id'],
                                          ),
                                        ),
                                      );
                                    }, 
                                    icon: const Icon(Icons.arrow_right_alt_rounded)
                                  )
                                ]
                              )
                            ),
                            if (index == restaurantList.length - 1) const SizedBox(height: 12)
                          ]
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
          Positioned(
            right: 26,
            bottom: 36,
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => FoodCartPage(
                //     restaurantId: grestaurantId,
                //     counterFromOrder: 0,
                //   )), 
                // );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              )
            )
          ),
        ]
      )
    );
  }
}