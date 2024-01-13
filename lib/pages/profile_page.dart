import 'package:flutter/material.dart';
import 'welcome_page.dart';
import '../theme/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Kiddovation';

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
                image: AssetImage("assets/background.png"),
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
                                'PROFILE',
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(
                                  Icons.shopping_cart,
                                  color: AppColors.white,
                                ),
                                onPressed: () {
                                  // Cart page
                                },
                              ),
                            ],
                          ),
                        ],
                      )),
                  const SizedBox(height: 30),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColors.secondary,
                                backgroundImage:
                                    AssetImage('assets/avatar.jpg'),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Wrap(
                                      spacing: 14,
                                      children: [
                                        Text('Admin',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.black)),
                                      ],
                                    ),
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
                                  buildRow('Number','+62 888 4444 2222'),
                                  buildDivider(),
                                  buildRow('Email', 'kiddovation@gmail.com'),
                                  buildDivider(),
                                  buildRow('Alamat', 'Bogor, Jawa Barat, Indonesia'),
                                  buildDivider(),
                                  buildRow('Poin', '1000'),
                                ],
                              )
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
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