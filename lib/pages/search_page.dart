import 'package:flutter/material.dart';
import 'foodorder_page.dart';
import '../themes/app_colors.dart';
import '../services/food_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  final FoodService foodController = FoodService();

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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: AppColors.white,
          child: Column(
            children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white, 
                          borderRadius: BorderRadius.circular(10), 
                        ),
                        child: TextField(
                          controller: searchController,
                          onChanged: (query) {
                            setState(() {
                              // search query
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Cari...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: 0.95, 
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
    );
  }

  Widget buildFoodCard(Map<String, dynamic> food) {
    double price = (double.parse(food['price'] ?? 0));
    String formattedPrice = price.toStringAsFixed(0);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodOrderPage(
              foodId: food['id'] ?? '-',
              foodName: food['name'] ?? '-',
              formattedPrice: formattedPrice,
              foodImage: food['thumb'] ?? '-',
              foodDescription: food['description'] ?? '-',
              restaurantId: food['restaurant_id'],
              // stock: food['stock'] ?? 0,
            ),
          ),
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
              child: Image.network(
                food['thumb'] ?? '-',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 80,
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
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$formattedPrice koin',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [ 
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Tersedia stok: ${food['stock'] ?? 0}',
                          style: const TextStyle(
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