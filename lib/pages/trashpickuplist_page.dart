import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TrashPickupListPage extends StatefulWidget {
  const TrashPickupListPage({Key? key}) : super(key: key);

  @override
  State<TrashPickupListPage> createState() => _TrashPickupListPageState();
}

class _TrashPickupListPageState extends State<TrashPickupListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan Masuk'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text('Order in pickup'),
                                Text('17 Jan 2023, 09:30 AM')
                              ]
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  'Lihat History', 
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white
                                  ),
                                )
                              )
                            ),
                          ]
                        )
                      ]
                    )
                  )
                ),
          ],
        ),
      ),
    );
  }

  Widget buildDivider() {
    return const Divider(
      height: 0.2,
      color: Colors.grey,
    );
  }
}
