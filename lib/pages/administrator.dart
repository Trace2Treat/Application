import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'welcome_page.dart';
import '../themes/app_colors.dart';
import '../themes/empty_data.dart';
import '../utils/session_manager.dart';
import '../services/trash_service.dart';

class Administrator extends StatefulWidget {
  const Administrator({Key? key}) : super(key: key);

  @override
  State<Administrator> createState() => _AdministratorState();
}

class _AdministratorState extends State<Administrator> {
  final TrashService trashService = TrashService();
  bool approvalFeature = false;
  bool approvedFeature = false;
  String formattedDate(String dateString) {
    DateTime parsedDate = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('EEEE, dd MMMM y', 'en_US');
    String formatted = formatter.format(parsedDate);

    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trce2Treat',
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primary,
          title: const Text('TRACE2TREAT ADMINISTRATOR', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Card(
              child: ListTile(
                title: Text('Approval Request'),
                leading: Icon(Icons.receipt),
                onTap: () {
                  setState(() {
                    approvalFeature = !approvalFeature;
                  });
                },
              ),
            ),
            Visibility(
              visible: approvalFeature == true,
              child: Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: trashService.getTrashListForAdmin(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                    } else if (snapshot.hasError) {
                      return const EmptyData();
                    } else {
                      List<Map<String, dynamic>> trashList = snapshot.data!;
                      return ListView.builder(
                        itemCount: trashList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Status: ${trashList[index]['status'] ?? '-'}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                                        Text(formattedDate(trashList[index]['created_at'] ?? '-')),
                                      ]
                                    ),
                                    const Spacer(),
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
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(30),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Visibility(
                                                        visible: trashList[index]['status'] == 'Approved',
                                                        child: const Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text('Telah disetujui oleh Admin!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                                          ]
                                                        ),
                                                      ),
                                                      const SizedBox(height: 16),
                                                      const Text('Order Detail', style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
                                                      const SizedBox(height: 8),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          const Text('Id'),
                                                          Text('#${trashList[index]['id'].toString()}'),
                                                        ]
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          const Text('Status'),
                                                          Text(trashList[index]['status']),
                                                        ]
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          const Text('Tipe Sampah'),
                                                          Text(trashList[index]['trash_type']),
                                                        ]
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          const Text('Berat Sampah'),
                                                          Text('${trashList[index]['trash_weight']} kg'),
                                                        ]
                                                      ),
                                                      const SizedBox(height: 18),
                                                      const Text('Pickup Address', style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
                                                      const SizedBox(height: 8),
                                                      Text(trashList[index]['place_name']),
                                                      const SizedBox(height: 18),
                                                      const Text('User Detail', style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
                                                      const SizedBox(height: 8),
                                                      Text(trashList[index]['user_name']),
                                                      Text(trashList[index]['phone'] ?? '-'),
                                                      Visibility(
                                                        visible: trashList[index]['status'] == 'Approved' || trashList[index]['status'] == 'Finished',
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            TextButton(
                                                              onPressed: () {
                                                                showDialog(
                                                                  context: context,
                                                                  builder: (BuildContext context) {
                                                                    return AlertDialog(
                                                                      content: Image.network(
                                                                          trashList[index]['proof_payment'] ?? 'https://static.vecteezy.com/system/resources/thumbnails/009/007/126/small/document-file-not-found-search-no-result-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg', 
                                                                          fit: BoxFit.cover,
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: const Text(
                                                                'Proof',
                                                                style: TextStyle(color: AppColors.primary, decoration: TextDecoration.underline),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ),
                                                      const SizedBox(height: 20),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              primary: AppColors.secondary,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20),
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              'Back',
                                                              style: TextStyle(color: Colors.white),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 10),
                                                          ElevatedButton(
                                                            onPressed: () async {
                                                              setState(() {
                                                                trashService.isLoading = true;
                                                              });

                                                              try {
                                                                  await trashService.postTrashUpdateStatus(trashList[index]['id'], 'Approved');
                                                                
                                                                    AnimatedSnackBar.rectangle(
                                                                      'Sukses',
                                                                      'Sampah akan dikirim ke Pengepul',
                                                                      type: AnimatedSnackBarType.success,
                                                                      brightness: Brightness.light,
                                                                    ).show(
                                                                      context,
                                                                    );

                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(builder: (context) => Administrator()), 
                                                                    );

                                                              } catch (e) {
                                                                  print('Error during posting: $e');
                                                                  AnimatedSnackBar.material(
                                                                      'Gagal, coba lagi !',
                                                                      type: AnimatedSnackBarType.error,
                                                                    ).show(context);

                                                                  setState(() {
                                                                    trashService.isLoading = false;
                                                                  });
                                                              }
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              primary: AppColors.primary,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20),
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              'Approve',
                                                              style: TextStyle(color: Colors.white),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
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
                                      child: const Text(
                                        'Detail',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: AppColors.secondary,
                                        backgroundImage: NetworkImage(trashList[index]['avatar'] ?? '-'),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              trashList[index]['user_name'] ?? '-',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              trashList[index]['phone'] ?? '-',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ]
                              )
                            )
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Approved Request'),
                leading: Icon(Icons.checklist),
                onTap: () {
                  setState(() {
                    approvedFeature = !approvedFeature;
                  });
                },
              ),
            ),
            Visibility(
              visible: approvedFeature == true,
              child: Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: trashService.getTrashAdminApproved(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                    } else if (snapshot.hasError) {
                      return const EmptyData();
                    } else {
                      List<Map<String, dynamic>> trashList = snapshot.data!;
                      return ListView.builder(
                        itemCount: trashList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Status: ${trashList[index]['status'] ?? '-'}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                                        Text(formattedDate(trashList[index]['created_at'] ?? '-')),
                                      ]
                                    ),
                                    const Spacer(),
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
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(30),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Visibility(
                                                        visible: trashList[index]['status'] == 'Approved',
                                                        child: const Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text('Anda telah menyetujui request ini!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                                          ]
                                                        ),
                                                      ),
                                                      const SizedBox(height: 16),
                                                      const Text('Order Detail', style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
                                                      const SizedBox(height: 8),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          const Text('Id'),
                                                          Text('#${trashList[index]['id'].toString()}'),
                                                        ]
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          const Text('Tipe Sampah'),
                                                          Text(trashList[index]['trash_type']),
                                                        ]
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          const Text('Berat Sampah'),
                                                          Text('${trashList[index]['trash_weight']} kg'),
                                                        ]
                                                      ),
                                                      const SizedBox(height: 18),
                                                      const Text('User Detail', style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
                                                      const SizedBox(height: 8),
                                                      Text(trashList[index]['user_name']),
                                                      Text(trashList[index]['phone'] ?? '-'),
                                                      Visibility(
                                                        visible: trashList[index]['status'] == 'Approved' || trashList[index]['status'] == 'Finished',
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            TextButton(
                                                              onPressed: () {
                                                                showDialog(
                                                                  context: context,
                                                                  builder: (BuildContext context) {
                                                                    return AlertDialog(
                                                                      content: Image.network(
                                                                          trashList[index]['proof_payment'] ?? 'https://static.vecteezy.com/system/resources/thumbnails/009/007/126/small/document-file-not-found-search-no-result-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg', 
                                                                          fit: BoxFit.cover,
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: const Text(
                                                                'Proof',
                                                                style: TextStyle(color: AppColors.primary, decoration: TextDecoration.underline),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ),
                                                      const SizedBox(height: 20),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              primary: AppColors.secondary,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20),
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              'Back',
                                                              style: TextStyle(color: Colors.white),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
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
                                      child: const Text(
                                        'Detail',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: AppColors.secondary,
                                        backgroundImage: NetworkImage(trashList[index]['avatar'] ?? '-'),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              trashList[index]['user_name'] ?? '-',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              trashList[index]['phone'] ?? '-',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ]
                              )
                            )
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            Card(
                    child: ListTile(
                      title: Text('Setting'),
                      leading: Icon(Icons.settings),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()));
                      },
                    ),
            ),
            Card(
                    child: ListTile(
                      title: Text('Log Out'),
                      leading: Icon(Icons.logout_rounded),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomePage()));
                        SessionManager().logout();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}