import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trace2treat/main.dart';
import '../theme/app_colors.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> with TickerProviderStateMixin {
  late bool isLoggedIn;
  late String savedTheme;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Lottie.asset('assets/nointernet.json'),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('No Internet Connection', style: TextStyle(color: AppColors.primary)),
                const SizedBox(height: 30),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Trace2Treat()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [Colors.white, AppColors.secondary],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            spreadRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                          child: Text(
                            'Try Again',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            )
          ),
    );
  }
}