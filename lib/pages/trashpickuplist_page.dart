import 'package:flutter/material.dart';
import 'package:bottom_navigation_view/bottom_navigation_view.dart';
import '../theme/app_colors.dart';

class TrashPickupListPage extends StatefulWidget {
  const TrashPickupListPage({Key? key}) : super(key: key);

  @override
  State<TrashPickupListPage> createState() => _TrashPickupListPageState();
}

class _TrashPickupListPageState extends State<TrashPickupListPage> {
  late final BottomNavigationController _controller;
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late List<Map<String, String>> items = [
      {
        'status': 'Order In Pickup',
        'date': '18 Jan 2023, 09:30 AM',
        'name': 'Diva Ariani',
        'address': 'Cibinong',
        'phone': '0888 1111 2222'
      },
      {
        'status': 'Finished',
        'date': '17 Jan 2023, 09:30 AM',
        'name': 'Agus',
        'address': 'SV IPB',
        'phone': '0888 4444 2222'
      },
      {
        'status': 'Finished',
        'date': '16 Jan 2023, 09:30 AM',
        'name': 'Rafi',
        'address': 'Gunung Putri',
        'phone': '0888 3333 2222'
      },
      {
        'status': 'Finished',
        'date': '15 Jan 2023, 09:30 AM',
        'name': 'Reksa',
        'address': 'Bogor Utara',
        'phone': '0888 5555 2222'
      }
    ];

    return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('Pesanan Masuk'),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(children: [
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text(items[index]['status']!, style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                                  Text(items[index]['date']!,)
                                ]),
                                Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          backgroundColor: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(30),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Order Detail', style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
                                                const SizedBox(height: 8),
                                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                  Text('Id'),
                                                  Text('#3333'),
                                                ]),
                                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                  Text('Status'),
                                                  Text('Delivery'),
                                                ]),
                                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                  Text('Payment'),
                                                  Text('Point'),
                                                ]),
                                                const SizedBox(height: 18),
                                                Text('User Detail', style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
                                                const SizedBox(height: 8),
                                                Text(items[index]['name']!),
                                                Text(items[index]['address']!),
                                                Text(items[index]['phone']!),
                                                const SizedBox(height: 8),
                                                Center(
                                                  child:ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: AppColors.secondary,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Back',
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),)
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColors.secondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Detail',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ]),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: AppColors.secondary,
                                    backgroundImage: AssetImage('assets/avatar.jpg'),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          items[index]['name']!,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          items[index]['address']!,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(color: Colors.black)),
                                        Text(
                                          items[index]['phone']!,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child:ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        items.removeAt(index); 
                                      });
                                    },
                                    
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      onPrimary: AppColors.secondary,
                                      side: BorderSide(color: AppColors.secondary, width: 2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: AppColors.secondary),
                                    ),
                                  ),),
                                  SizedBox(width: 16), 
                                  Expanded(
                                    child:ElevatedButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => TrashDetailPage()),
                                      // );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      'Deliver',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),)
                                ],
                              )
                            ]
                          )
                        )
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
  }
}