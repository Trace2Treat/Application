import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'register_page.dart';
import 'home_page.dart';
import '../services/login_service.dart';
import '../themes/app_colors.dart';
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
                      

                      final id = loginResult['id'];
                      final name = loginResult['name'];
                      final emailnya = loginResult['email'];
                      final balanceCoin = loginResult['balance_coin'];
                      final phone = loginResult['phone'];
                      final address = loginResult['address'];
                      final avatar = loginResult['avatar'];
                      final role = loginResult['role'];
                      final status = loginResult['status'];

                      SessionManager().saveUserData(
                        userId: id ?? '',
                        userName: name ?? '',
                        userEmail: emailnya ?? '',
                        userPoin: balanceCoin ?? '',
                        userPhone: phone ?? '',
                        userRole: role ?? '',
                        userAddress: address ?? '',
                        userAvatar: avatar ?? '',
                        userStatus: status ?? '',
                      );
                    
                      AnimatedSnackBar.rectangle(
                          'Sukses',
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

                        SessionManager().setLoggedIn(true);

                      print('idnya $id, namanya $name, emailnya $email');
                      print('role $role, poinnya $balanceCoin, phonenya $phone');
                    } catch (e) {
                      print('Error during login: $e');
                      AnimatedSnackBar.material(
                          'Gagal masuk, coba lagi !',
                          type: AnimatedSnackBarType.error,
                        ).show(context);

                      setState(() {
                        controller.isLoading = false;
                      });
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
                      child: controller.isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                          )
                        : const Text(
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