import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trace2treat/main.dart';
import '../theme/app_colors.dart';
import '../utils/session_manager.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> with TickerProviderStateMixin {
  late bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    initAsyncData();
  }

  Future<void> initAsyncData() async {
    final sessionManager = SessionManager();
    isLoggedIn = await sessionManager.isLoggedIn();
    setState(() {}); 
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
                const Text('Tidak ada koneksi internet', style: TextStyle(color: AppColors.primary)),
                const SizedBox(height: 30),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Trace2Treat(isLoggedIn: isLoggedIn)),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primary,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                          child: Text(
                            'Coba Lagi',
                            style: TextStyle(
                              color: AppColors.white,
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