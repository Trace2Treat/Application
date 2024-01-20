import 'package:flutter/material.dart';
import 'refresh_page.dart';
import 'exchangedetail_page.dart';
import '../api/trash_service.dart';
import '../theme/app_colors.dart';

class ExchangeListPage extends StatefulWidget {
  const ExchangeListPage({Key? key}) : super(key: key);

  @override
  State<ExchangeListPage> createState() => _ExchangeListPageState();
}

class _ExchangeListPageState extends State<ExchangeListPage> {
  final TrashService trashService = TrashService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trash List'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                  primary: Colors.transparent,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(56),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 36, minWidth: 88),
                    alignment: Alignment.center,
                    child: const Text(
                      'Tukar',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ),
          ),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: trashService.getTrashList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data == null) {
                return Center(child: Text('No data available'));
              } else {
                List<Map<String, dynamic>> trashList = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: trashList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white, 
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
                              Text('Point earned: ${trashList[index]['point'] ?? 'pending'}'),
                              Text('Status: ${trashList[index]['status']}')
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ExchangeDetailPage()), 
                              );
                            }, 
                            icon: Icon(Icons.arrow_right_alt_rounded)
                          )
                        ]
                      )
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       'Trash Type: ${trashList[index]['trash_type']}',
                      //       style: TextStyle(fontWeight: FontWeight.bold),
                      //     ),
                      //     SizedBox(height: 8.0),
                      //     Text('Trash Weight: ${trashList[index]['trash_weight']} (kg)'),
                      //     Text('Status: ${trashList[index]['status']}'),
                      //     // Add more Text widgets as needed
                      //   ],
                      // ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}