import 'package:flutter/material.dart';
import 'foodtrackorder_page.dart';
import 'home_page.dart';
import '../themes/app_colors.dart';

class OrderSuccessPage extends StatefulWidget {
  const OrderSuccessPage({Key? key}) : super(key: key);

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {

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
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Spacer(),
              const Text(
                'Selamat',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Kamu berhasil melakukan penukaran!',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => const TrackOrderPage()
                    ), 
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('OK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}