import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'theme/app_colors.dart';
import 'pages/nointernet_page.dart';
import 'pages/welcome_page.dart';
import 'pages/home_page.dart';
import 'pages/refresh_page.dart';
import 'utils/session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sessionManager = SessionManager();
  await sessionManager.initPrefs();

  final isLoggedIn = await sessionManager.isLoggedIn();

  runApp(Trace2Treat(isLoggedIn: isLoggedIn));
}

class Trace2Treat extends StatelessWidget {
  final bool isLoggedIn;

  const Trace2Treat({Key? key, required this.isLoggedIn}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id', 'ID'),
        Locale('en', 'US'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Trace2Treat',
      theme: ThemeData(
        useMaterial3: false,
        primaryColor: AppColors.primary,
        primarySwatch: const MaterialColor(
          0xFF06B059,
          <int, Color>{
            50: AppColors.primary,
            100: AppColors.primary,
            200: AppColors.primary,
            300: AppColors.primary,
            400: AppColors.primary,
            500: AppColors.primary,
            600: AppColors.primary,
            700: AppColors.primary,
            800: AppColors.primary,
            900: AppColors.primary,
          },
        ),
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      ),
      home: FutureBuilder<bool>(
        future: isConnectedToInternet(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error checking internet connection'));
          } else {
            return snapshot.data == true
              ? (isLoggedIn ? (SessionManager().getUserRole() == 'DRIVER' ? const RefreshHomePage() : const HomePage()) : const SplashScreen())
              : const NoInternetPage();
          }
        },
      ),
    );
  }

  Future<bool> isConnectedToInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/logo.png', 
                width: 200, 
                height: 200, 
              ),
            ),
            const Text('Trace2Treat!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))
          ]
        )
      ),
    );
  }
}