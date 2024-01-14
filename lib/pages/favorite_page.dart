import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: AppColors.white,
          child: Column(
            children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white, 
                          borderRadius: BorderRadius.circular(10), 
                        ),
                        child: TextField(
                          controller: searchController,
                          onChanged: (query) {
                            setState(() {
                              // search query
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Cari...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: 2, 
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Image.asset(
                                  'assets/defaultmakanan.png',
                                  fit: BoxFit.cover,
                                  width: double.infinity, 
                                  height: 80,
                                ),
                                const SizedBox(height: 8),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 23),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Cheese Burger',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Rp 15.000',
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Icon(Icons.favorite, color: AppColors.primary),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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