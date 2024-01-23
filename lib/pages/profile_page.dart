import 'package:flutter/material.dart';
import 'welcome_page.dart';
import '../themes/app_colors.dart';
import '../utils/session_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('PROFILE', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColors.secondary,
                                backgroundImage: NetworkImage(SessionManager().getUserAvatar() ?? 'assets/avatar.jpg'),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      SessionManager().getUserName() ?? '',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      SessionManager().getUserRole() ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(color: Colors.black)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Card(
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: AppColors.white,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildRow('Telepon', SessionManager().getUserPhone() ?? ''),
                                  buildDivider(),
                                  buildRow('Email', SessionManager().getUserEmail() ?? ''),
                                  buildDivider(),
                                  buildRow('Alamat', SessionManager().getUserAddress() ?? ''),
                                  buildDivider(),
                                  buildRow('Poin', '${SessionManager().getUserPoin()}'),
                                ],
                              )
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              SessionManager().logout();

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const WelcomePage(),
                                ),
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
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(56),
                              ),
                              child: Container(
                                constraints: const BoxConstraints(minHeight: 36, minWidth: 88),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Keluar',
                                  style: TextStyle(color: AppColors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text1, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          Text(text2, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return const Divider(
      height: 0.5,
      color: Colors.grey,
    );
  }
}