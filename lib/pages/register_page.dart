import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'login_page.dart';
import '../theme/app_colors.dart';
import '../api/register_service.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterService controller = RegisterService();

  bool isPasswordVisible = false;
  bool isPasswordConfirmVisible = false;
  String name = '';
  String email = '';
  String password = '';
  String passwordConfirm = '';
  String phone = '';
  String address = '';
  String role = 'USER';

  CustomFile? pickedFile;
  String attachment = '';
  String file = 'Add Profile Photo';
  double uploadProgress = 0.0;
  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = CustomFile(
          result.files.first.path ?? '', result.files.first.name);
          
    });
  }
  Future<void> uploadFile() async {
    if (pickedFile != null) {
      final path = 'files/${pickedFile!.name}';
      final file = File(pickedFile!.path);

      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putFile(file);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        setState(() {
          uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
        });
      });

      final snapshot = await uploadTask.whenComplete(() {});

      final urlDownload = await snapshot.ref.getDownloadURL();
      setState(() {
        attachment = urlDownload;
      });
      
      print('Direct Image Link: $urlDownload');
    } else {
      print('No file selected');
    }
  }

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
                Center(
                  child: Image.asset(
                    'assets/logo.png', 
                    height: MediaQuery.of(context).size.height * 0.2, 
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                          setState(() {
                            name = value;
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
                      Icons.person, 
                      color: Colors.grey[600],
                    ),
                    hintText: 'Enter your username',
                  ),
                ),
                const SizedBox(height: 5),
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
                const SizedBox(height: 5),
                TextField(
                  onChanged: (value) {
                          setState(() {
                            passwordConfirm = value;
                          });
                        },
                  obscureText: !isPasswordConfirmVisible,
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
                    hintText: 'Enter your Password Confirm',
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordConfirmVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey[600],
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordConfirmVisible = !isPasswordConfirmVisible;
                        });
                      },
                    ),
                  )
                ),
                const SizedBox(height: 5),
                TextField(
                  onChanged: (value) {
                          setState(() {
                            phone = value;
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
                      Icons.phone,
                      color: Colors.grey[600],
                    ),
                    hintText: 'Enter your Phone Number',
                  )
                ),
                const SizedBox(height: 5),
                TextField(
                  onChanged: (value) {
                          setState(() {
                            address = value;
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
                      Icons.map, 
                      color: Colors.grey[600],
                    ),
                    hintText: 'Enter your Address',
                  ),
                ),
                const SizedBox(height: 5),
                Card(
                  color: Colors.grey[200],
                      margin: EdgeInsets.zero,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(Icons.people, color: Colors.grey[600]),
                            const SizedBox(width: 10),
                            DropdownButton<String>(
                              value: role,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    role = newValue;
                                  });
                                }
                              },
                              items: <String>['USER', 'DRIVER', 'RESTAURANT_OWNER', 'WASTE_COLLECTOR'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(color: Colors.grey[600])),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                const SizedBox(height: 10),
                Card(
                  color: Colors.grey[200],
                      margin: EdgeInsets.zero,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          await selectFile();
                          await uploadFile();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(Icons.insert_photo, size: 24, color: Colors.grey[600]),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  pickedFile == null ? file : pickedFile!.name,
                                  maxLines: 1, 
                                  overflow: TextOverflow.ellipsis, 
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                              const Spacer(),
                              Icon(Icons.add, size: 24, color: Colors.grey[600]),
                            ],
                          ),
                        ),
                      ),
                    ),
                const SizedBox(height: 10),
                Visibility(
                  visible: pickedFile != null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: LinearProgressIndicator(
                              value: uploadProgress,
                              minHeight: 10,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.secondary),
                            ),
                          ),
                        ],
                      ),
                  )
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (password.length < 8 && passwordConfirm.length < 8) {
                      AnimatedSnackBar.material(
                        'Password minimal 8 karakter',
                        type: AnimatedSnackBarType.warning,
                      ).show(context);
                      return;
                    }

                    setState(() {
                      controller.isLoading = true;
                    });

                    try {
                      await controller.postRegister(name, email, password, passwordConfirm, phone, address, role, attachment);
                    
                        AnimatedSnackBar.rectangle(
                          'Sukses',
                          'Anda berhasil mendaftar',
                          type: AnimatedSnackBarType.success,
                          brightness: Brightness.light,
                        ).show(
                          context,
                        );

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );

                    } catch (e) {
                      print('Error during register: $e');
                      AnimatedSnackBar.material(
                          'Gagal mendaftar, coba lagi !',
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
                      child:  controller.isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                          )
                        : const Text(
                            'Daftar',
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
                      'Sudah punya akun?',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Masuk',
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

class CustomFile {
  final String path;
  final String name;

  CustomFile(this.path, this.name);
}