import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'welcome_page.dart';
import '../themes/app_colors.dart';
import '../themes/empty_data.dart';
import '../services/trash_service.dart';

class Administrator extends StatefulWidget {
  const Administrator({Key? key}) : super(key: key);

  @override
  State<Administrator> createState() => _AdministratorState();
}

class _AdministratorState extends State<Administrator> {
  final TrashService trashController = TrashService();

  String formattedDate(String dateString) {
    DateTime parsedDate = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('EEEE, dd MMMM y', 'id_ID');
    String formatted = formatter.format(parsedDate);

    return formatted;
  }
  bool approvalFeature = false;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primary,
          title: const Text('TRACE2TREAT ADMINISTRATOR', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          centerTitle: true,
        ),
        body: Row(
          children: [
            Expanded(
              child: ListView(
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
                    child: buildTrashList()
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Data Pengguna'),
                      leading: Icon(Icons.people),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => UserDataPage()));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Data Driver'),
                      leading: Icon(Icons.drive_eta),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => DriverDataPage()));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Transaksi'),
                      leading: Icon(Icons.receipt),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionPage()));
                      },
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTrashList() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: trashController.getTrashListForAdmin(),
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

          return Expanded(
            child: ListView.builder(
              itemCount: trashList.length,
              itemBuilder: (context, index) {

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
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
                              Row(children: [
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text(trashList[index]['status'], style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                                  Text(formattedDate(trashList[index]['created_at']))
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
                                                  const Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('Delivery Payment'),
                                                      Text('Cash'),
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
                                                  Text(trashList[index]['phone']),
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
                                                                      trashList[index]['proof_payment'], 
                                                                      fit: BoxFit.cover,
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: const Text(
                                                            'Lihat bukti',
                                                            style: TextStyle(color: AppColors.secondary, decoration: TextDecoration.underline),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Center(
                                                    child: ElevatedButton(
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
                                    backgroundImage: NetworkImage(trashList[index]['avatar']),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          trashList[index]['user_name'],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          trashList[index]['phone'],
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Visibility(
                                visible: trashList[index]['status'] != 'Finished',
                                child: Row(
                                  children: [
                                    Expanded(
                                      child:ElevatedButton(
                                      onPressed: () {
                                        // change status
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text(
                                        'Setujui',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            )
                          ]
                        )
                      )
                    );
                  },
            )
          );
        }
      },
    );
  }
}