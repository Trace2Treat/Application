import 'package:flutter/material.dart';
import 'refresh_page.dart';
import 'exchangedetail_page.dart';
import 'home_page.dart';
import '../services/trash_service.dart';
import '../themes/app_colors.dart';
import '../themes/empty_data.dart';

class ExchangeListPage extends StatefulWidget {
  const ExchangeListPage({Key? key}) : super(key: key);

  @override
  State<ExchangeListPage> createState() => _ExchangeListPageState();
}

class _ExchangeListPageState extends State<ExchangeListPage> {
  final TrashService controller = TrashService();

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
          title: const Text('Daftar Pengumpulan'),
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            ListView(
              children: [
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: controller.getTrashList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
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
                          return Column(
                            children:[
                              if (index == 0) const SizedBox(height: 12),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.grey, 
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset('assets/trash.png', height: 16, width: 16),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(trashList[index]['date'], style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text('Tipe sampah: ${trashList[index]['trash_type']}'),
                                        Text('Koin didapat: ${trashList[index]['point'] ?? 'Pending'}'),
                                        Text('Status: ${trashList[index]['status']}', style: TextStyle(color: trashList[index]['status'] == 'Approved' ? AppColors.primary : Colors.black))
                                      ],
                                    ),
                                    Spacer(),
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
                                      icon: const Icon(Icons.arrow_right_alt_rounded)
                                    )
                                  ]
                                )
                              ),
                              if (index == trashList.length - 1) const SizedBox(height: 12)
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
              left: 16,
              right: 16,
              bottom: 26,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RefreshTrashForm()), 
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                  primary: AppColors.primary,
                ),
                child: Container(
                  constraints: const BoxConstraints(minHeight: 50),
                  alignment: Alignment.center,
                  child: const Text(
                    'Tambah Pengumpulan',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}