import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'foodtrack_page.dart';
import 'foodcart_page.dart';
import 'restaurants_page.dart';
import 'exchangedetail_page.dart';
import 'exchangelist_page.dart';
import '../themes/app_colors.dart';
import '../themes/empty_data.dart';
import '../utils/session_manager.dart';
import '../utils/cart_data.dart';
import '../utils/globals.dart';
import '../services/trash_service.dart';
import '../services/transaction_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final CarouselController controller = CarouselController();
  final TrashService trashController = TrashService();
  final TransactionService transactionController = TransactionService();
  late Widget trashListFutureBuilder;
  late List<Transaction> transactions = [];
  List<String> imageAssets = [
    'assets/banner.png',
    'assets/banner.png',
    'assets/banner.png',
  ];

  int currentIndex = 0;
  int restaurantId = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    trashListFutureBuilder = buildTrashList();
    fetchData();
  }
  
  Future<void> fetchData() async {
    try {
      await fetchTransactions();
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

  Future<void> fetchTransactions() async {
    setState(() {
      transactionController.isLoading = true;
    });
    try {
      final List<Transaction> result = await transactionController.getTransactions();
      
      result.sort((a, b) => b.id.compareTo(a.id));

      setState(() {
        transactions = result.isNotEmpty ? [result.first] : [];
        restaurantId = transactions[0].restoId;
        print('resto id nya $restaurantId');
      });
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.white,
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Halo, ${SessionManager().getUserName()}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(
                                Icons.notifications,
                                color: Colors.black,
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
                Padding(
                    padding: const EdgeInsets.only(left: 30, right: 10),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 30),
                          height: 146,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/wallet.png', height: 30, width: 30),
                                    const SizedBox(width: 5),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Metode ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text(
                                          'Pembayaran',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset('assets/point.png', height: 16, width: 16),
                                            const SizedBox(width: 5),
                                            const Text(
                                              'Koin Kamu',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold
                                              ),
                                            )
                                          ]
                                        ),
                                        Text('${SessionManager().getUserPoin()}', style: const TextStyle(color: Colors.white, fontSize: 14))
                                      ],
                                    )
                                  ]
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          child: SizedBox(
                                            height: 40, 
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              color: AppColors.primary,
                                              child: const Row(
                                                  children: [
                                                    SizedBox(width: 10),
                                                    Text(
                                                      'Resto terdekat',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Icon(Icons.arrow_drop_down_circle, color: Colors.white),
                                                    SizedBox(width: 70)
                                                  ]
                                                )
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: (){
                                              if (cartProvider.items.isNotEmpty) {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => FoodCartPage(restaurantId: grestaurantId),
                                                  ),
                                                );
                                              } else {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => const RestaurantsPage(),
                                                  ),
                                                );
                                              }

                                              if (transactions[0].status == 'pending' || transactions[0].status == 'preparing' || transactions[0].status == 'prepared'){
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => const TrackOrderPage(),
                                                  ),
                                                );
                                              } else {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => const RestaurantsPage(),
                                                  ),
                                                );
                                              }
                                            },
                                            child: SizedBox(
                                            height: 40,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              color: AppColors.secondary,
                                              child: const Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Order',
                                                    style: TextStyle(
                                                      fontSize: 14, 
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                ]
                                              ),
                                            ),
                                          ),
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            )
                          ),
                        ],
                      )
                  ),
                const SizedBox(height: 10),
                CarouselSlider(
                  items: imageAssets.map((asset) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(asset, fit: BoxFit.cover)
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
                          const Text('Pengumpulan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          TextButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ExchangeListPage()), 
                              );
                            }, 
                            child: const Text('Lihat Semua', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.secondary))
                          )
                        ]
                      ),
                      const SizedBox(height: 10),
                      trashListFutureBuilder,
                      const SizedBox(height: 10),
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

  Widget buildTrashList() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: trashController.getTrashList(),
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

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: trashList.length,
            itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Image.asset('assets/trash.png', height: 24, width: 24),
                    const SizedBox(width: 10),
                    Expanded( 
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(trashList[index]['date'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('Tipe sampah: ${trashList[index]['trash_type']}'),
                          Text('Koin didapat: ${trashList[index]['point'] ?? 'Pending'}'),
                          Text('Status: ${trashList[index]['status']}', style: TextStyle(color: trashList[index]['status'] == 'Approved' ? AppColors.primary : Colors.black))
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExchangeDetailPage(
                                selectedData: trashList[index],
                              ),
                            ),
                          );
                      },
                    icon: const Icon(Icons.arrow_right_alt_rounded))
                  ]
                )
              );
            },
          );
        }
      },
    );
  }
}