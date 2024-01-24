import 'dart:io';
import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'login_page.dart';
import '../themes/app_colors.dart';
import '../themes/custom_file.dart';
import '../services/register_service.dart';
import '../utils/globals.dart';

class RegisterRestaurantPage extends StatefulWidget {
  const RegisterRestaurantPage({Key? key}) : super(key: key);

  @override
  State<RegisterRestaurantPage> createState() => _RegisterRestaurantPageState();
}

class _RegisterRestaurantPageState extends State<RegisterRestaurantPage> {
  RegisterService controller = RegisterService();

  bool isPasswordVisible = false;
  bool isPasswordConfirmVisible = false;
  String name = '';
  String description = '';
  String phone = '';

  CustomFile? pickedFile;
  String attachment = '';
  String file = 'Add Logo';
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Center(
                  child: Image.asset(
                    'assets/logo.png', 
                    height: MediaQuery.of(context).size.height * 0.2, 
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Daftar keterangan resto terlebih dahulu.', 
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal), 
                  textAlign: TextAlign.center,
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
                      Icons.restaurant_menu, 
                      color: Colors.grey[600],
                    ),
                    hintText: 'Enter restaurant name',
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  onChanged: (value) {
                          setState(() {
                            description = value;
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
                      Icons.description, 
                      color: Colors.grey[600],
                    ),
                    hintText: 'Enter description',
                  ),
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
                    hintText: 'Enter restaurant call number',
                  )
                ),
                const SizedBox(height: 5),
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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

                    setState(() {
                      controller.isLoading = true;
                    });

                    try {
                      await controller.postRestaurantRegister(name, description, phone, attachment, globalLat, globalLong, globalLocationName);
                    
                        AnimatedSnackBar.rectangle(
                          'Sukses',
                          'Anda berhasil mendaftarkan resto',
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
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}