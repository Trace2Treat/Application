import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/dashboard.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 10, top: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'PROFILE',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_basket_rounded,
                          color: AppColors.primary,
                        ),
                        onPressed: () {
                          // Notification page
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Row(
                              children: [
                                const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: AppColors.secondary,
                                  backgroundImage: AssetImage('assets/avatar.jpg'),
                                ),
                                const SizedBox(width: 10),
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
                                          Text(
                                            'Driver',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(color: Colors.black)
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      const SizedBox(height: 10),
                      
                    ],
                  )
                )
              ],
            ),
        ),
      ),
    );
  }
}