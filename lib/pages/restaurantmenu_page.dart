import 'package:flutter/material.dart';
import '../themes/empty_data.dart';
import '../services/restaurant_service.dart';

class RestoMenuPage extends StatelessWidget {
  final int restaurantId;

  RestoMenuPage({required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: RestaurantService().getFoodEachRestaurant('$restaurantId'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return EmptyData();
          } else if (snapshot.data == null) {
            return EmptyData();
          } else {
            List<Map<String, dynamic>> foodList = snapshot.data!;
            
            return ListView.builder(
              itemCount: foodList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(foodList[index]['name']),
                  subtitle: Text(foodList[index]['description']),
                  // Add other widgets as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}