import 'package:flutter/material.dart';
import 'trashdetail_page.dart';
import '../theme/app_colors.dart';

class DashboardDriverPage extends StatefulWidget {
  const DashboardDriverPage({Key? key}) : super(key: key);

  @override
  State<DashboardDriverPage> createState() => _DashboardDriverPageState();
}

class _DashboardDriverPageState extends State<DashboardDriverPage> {
  String name = 'Abang';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/dashboard.png"),
                fit: BoxFit.cover,
              ),
            ),
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
                              'Halo, $name',
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(
                                Icons.notifications,
                                color: AppColors.white,
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                                child: Row(
                                  children: [
                              Image.asset('assets/trash.png', height: 16, width: 16),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Selasa, 16 Januari 2024', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Username: Diva Ariani'),
                                  Text('Berat Sampah: 0.2 kg'),
                                  Text('Lokasi: SV IPB'),
                                  Text('Jarak: 7km dari Lokasi Saya')
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const TrashDetailPage()), 
                                  );
                                }, 
                                icon: Icon(Icons.arrow_right_alt_rounded)
                              )
                            ]
                          )
                        )
                      ),
                      const SizedBox(height: 10),
                      Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                                child: Row(
                                  children: [
                              Image.asset('assets/trash.png', height: 16, width: 16),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Selasa, 16 Januari 2024', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Username: Reksa'),
                                  Text('Berat Sampah: 0.2 kg'),
                                  Text('Lokasi: SV IPB'),
                                  Text('Jarak: 7km dari Lokasi Saya')
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const TrashDetailPage()), 
                                  );
                                }, 
                                icon: Icon(Icons.arrow_right_alt_rounded)
                              )
                            ]
                          )
                        )
                      ),
                      const SizedBox(height: 10),
                      Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                                child: Row(
                                  children: [
                              Image.asset('assets/trash.png', height: 16, width: 16),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Selasa, 16 Januari 2024', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Username: Muhammad Rafi'),
                                  Text('Berat Sampah: 0.2 kg'),
                                  Text('Lokasi: SV IPB'),
                                  Text('Jarak: 7km dari Lokasi Saya')
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const TrashDetailPage()), 
                                  );
                                }, 
                                icon: Icon(Icons.arrow_right_alt_rounded)
                              )
                            ]
                          )
                        )
                      ),
                      const SizedBox(height: 10),
                      Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                                child: Row(
                                  children: [
                              Image.asset('assets/trash.png', height: 16, width: 16),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Selasa, 16 Januari 2024', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Username: Muhammad Rizki'),
                                  Text('Berat Sampah: 0.2 kg'),
                                  Text('Lokasi: SV IPB'),
                                  Text('Jarak: 7km dari Lokasi Saya')
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const TrashDetailPage()), 
                                  );
                                }, 
                                icon: Icon(Icons.arrow_right_alt_rounded)
                              )
                            ]
                          )
                        )
                      ),
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
}