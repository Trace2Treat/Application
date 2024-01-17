import 'package:flutter/material.dart';
import 'foodtrackorder_page.dart';
import '../theme/app_colors.dart';

class OrderSuccessPage extends StatefulWidget {
  const OrderSuccessPage({Key? key}) : super(key: key);

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Spacer(),
            Text(
              'Selamat',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Kamu berhasil melakukan penukaran!',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => const TrackOrderPage()
                  ), 
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Lacak Pesanan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}