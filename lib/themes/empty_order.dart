import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'app_colors.dart';
import '../pages/restaurants_page.dart';

class EmptyOrder extends StatefulWidget {
  const EmptyOrder({Key? key}) : super(key: key);

  @override
  State<EmptyOrder> createState() => _EmptyOrderState();
}

class _EmptyOrderState extends State<EmptyOrder> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RestaurantsPage()),
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
                MaterialPageRoute(builder: (context) => const RestaurantsPage()), 
              );
            },
          ),
          title: const Text('Pesanan'),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Lottie.asset('assets/noorder.json'),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Anda belum memiliki orderan', style: TextStyle(color: AppColors.primary)),
                ],
              )
            )
          ),
    );
  }
}