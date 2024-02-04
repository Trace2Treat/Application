import 'package:flutter/material.dart';
import 'foodorder_page.dart';
import '../themes/app_colors.dart';
import '../themes/empty_data.dart';
import '../services/restaurant_service.dart';

class RestoMenuPage extends StatefulWidget {
  final int restaurantId;

  const RestoMenuPage({
    required this.restaurantId, 
    Key? key}) : super(key: key);

  @override
  State<RestoMenuPage> createState() => _RestoMenuPageState();
}

class _RestoMenuPageState extends State<RestoMenuPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Menu'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: RestaurantService().getFoodEachRestaurant(widget.restaurantId.toString()),
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
              itemCount: foodList.length,
              itemBuilder: (context, index) {
                double price = (double.parse(foodList[index]['price'] ?? 0)) / 100;
                String formattedPrice = price.toStringAsFixed(0);

                return Column(
                  children: [
                    if (index == 0) const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodOrderPage(
                              foodId: foodList[index]['id'] ?? '-',
                              foodName: foodList[index]['name'] ?? '-',
                              formattedPrice: formattedPrice,
                              foodImage: foodList[index]['thumb'] ?? '-',
                              foodDescription: foodList[index]['description'] ?? '-',
                              restaurantId: foodList[index]['restaurant_id'],
                              // stock: foodList[index]['stock'] ?? 0,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                foodList[index]['thumb'] ?? '-',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 150,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    foodList[index]['name'] ?? '-',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '$formattedPrice Koin',
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
                                          'Tersedia stok: ${foodList[index]['stock'] ?? 0}',
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
                    ),
                    if (index == foodList.length - 1) const SizedBox(height: 12)
                  ]
                );
              },
            );
          }
        },
      ),
    );
  }
}