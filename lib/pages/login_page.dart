import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'register_page.dart';
import 'home_page.dart';
import '../api/login_service.dart';
import '../api/config.dart';
import '../theme/app_colors.dart';
import '../utils/session_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginService controller = LoginService();
  bool isPasswordVisible = false;
  String email = '';
  String password = '';

  // void loginButtonPressed() async {
  //   setState(() {
  //     controller.isLoading = true;
  //   });

  //   try {
  //     await controller.postLogin(
  //       email,
  //       password,
  //     );

  //   } catch (error) {

  //   } finally {
  //     setState(() {
  //       controller.isLoading = false;
  //     });
  //   }
  // }

  // Future<Map<String, dynamic>> loginUser(String email, String password) async {
  //   final loginUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/login');
    
  //   final response = await http.post(
  //     loginUrl,
  //     body: {
  //       'email': email,
  //       'password': password,
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final responseData = json.decode(response.body);
  //     final accessToken = responseData['access_token'];

  //     final userData = await getUserData(accessToken);

  //     return userData;
  //   } else {
  //     throw Exception('Failed to login');
  //   }
  // }

  // Future<Map<String, dynamic>> getUserData(String accessToken) async {
  //   final userUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/user');

  //   final response = await http.get(
  //     userUrl,
  //     headers: {'Authorization': 'Bearer $accessToken'},
  //   );

  //   if (response.statusCode == 200) {
  //     final userData = json.decode(response.body);

  //     final filteredData = {
  //       'id': userData['id'],
  //       'name': userData['name'],
  //     };

  //     return filteredData;
  //   } else {
  //     throw Exception('Failed to get user data');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Center(
                  child: Image.asset(
                    'assets/logo.png', 
                    height: MediaQuery.of(context).size.height * 0.2, 
                  ),
                ),
                const Text(
                  'Selamat datang di Trace2Treat!', 
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Masuk atau daftar hanya dalam beberapa langkah mudah.', 
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal), 
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.email, 
                      color: Colors.grey[600],
                    ),
                    hintText: 'Enter your email',
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.grey[600],
                    ),
                    hintText: 'Enter your Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey[600],
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  )
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      controller.isLoading = true;
                    });

                    try {
                      final loginResult = await controller.loginUser(email, password);
                      SessionManager().setLoggedIn(true);
                      

                        AnimatedSnackBar.rectangle(
                          'Success',
                          'Anda berhasil masuk',
                          type: AnimatedSnackBarType.success,
                          brightness: Brightness.light,
                        ).show(
                          context,
                        );

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );

                      final id = loginResult['id'];
                      final name = loginResult['name'];
                      final emailnya = loginResult['email'];
                      // final phone = loginResult['phone'];
                      // final address = loginResult['address'];
                      // final avatar = loginResult['avatar'];
                      // final role = loginResult['role'];
                      final balanceCoin = loginResult['balance_coin'];
                      //final status = loginResult['status'];

                      await SessionManager.saveUserData(id, name, emailnya, balanceCoin);

                    } catch (e) {
                      print('Error during login: $e');
                      AnimatedSnackBar.material(
                          'Gagal masuk, coba lagi !',
                          type: AnimatedSnackBarType.error,
                        ).show(context);
                    }
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
                        'Masuk',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.left, 
                  text: TextSpan(
                    text: 'Saya menyetujui ',
                    style: TextStyle(
                      color: Colors.black, 
                    ),
                    children: [
                      TextSpan(
                        text: 'Ketentuan Layanan',
                        style: TextStyle(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // ketentuan layanan page
                          },
                      ),
                      TextSpan(
                        text: ' & ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Kebijakan Privasi ',
                        style: TextStyle(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // kebijakan privasi page
                          },
                      ),
                      TextSpan(
                        text: 'Trace2Treat.',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum memiliki akun?',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Daftar',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}