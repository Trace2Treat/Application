import 'package:flutter/material.dart';
import 'foodtrackorder_page.dart';
import 'restaurantmenu_page.dart';
import 'home_page.dart';
import '../services/restaurant_service.dart';
import '../services/transaction_service.dart';
import '../themes/app_colors.dart';
import '../themes/empty_data.dart';
import '../utils/globals.dart';
import '../utils/session_manager.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  State<RestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  final RestaurantService controller = RestaurantService();
  final TransactionService controllerTransaction = TransactionService();
  List<Map<String, dynamic>> transactions = [];
  Map<String, dynamic> restaurant = {};

  int restaurantId = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      await fetchTransactionData();
      await fetchRestaurantData();
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> fetchTransactionData() async {
    try {      
      transactions = await controllerTransaction.getTransaction();
      if (mounted) {
        setState(() {
          transactions = transactions;
          restaurantId = transactions[0]['restaurant_id'];
        });
      }
    } catch (e) {
      print('Error fetching transaction data: $e');
    }
  }

  Future fetchRestaurantData() async {
    print(transactions[0]['items']);
    final String accessToken = SessionManager().getAccess() ?? '';

    try {
      final restaurantService = RestaurantService();

      restaurant = await restaurantService.fetchRestaurantData(restaurantId, accessToken);

    } catch (e) {
      print('Error fetching data: $e');
    }
  }

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
                                          grestaurantId = restaurantList[index]['id'];
                                          grestaurantName = restaurantList[index]['name'];
                                          grestaurantAddress = restaurantList[index]['address'];
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
                  if (transactions[0]['items'].isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TrackOrderPage()), 
                    );
                  } else {
                    //history page
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                )
              )
            ),
          ]
        )
      )
    );
  }
}