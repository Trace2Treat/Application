import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'exchangelist_page.dart';
import '../theme/app_colors.dart';
import '../api/trash_service.dart';
import '../utils/globals.dart';

class ExchangeFormPage extends StatefulWidget {
  const ExchangeFormPage({Key? key}) : super(key: key);

  @override

  State<ExchangeFormPage> createState() => _ExchangeFormPageState();
}

class _ExchangeFormPageState extends State<ExchangeFormPage> {
  TrashService controller = TrashService();
  TextEditingController typeController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ExchangeListPage()), 
            );
          },
        ),
        title: Text('Tukar Sampah'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: typeController,
              decoration: InputDecoration(
                labelText: 'Tipe Sampah...',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Berat Sampah (gr)...',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                  onPressed: () async {

                    setState(() {
                      controller.isLoading = true;
                    });

                    double weightValue = int.parse(weightController.text) / 1000;

                    try {
                      await controller.postTrashRequest(typeController.text, '$weightValue', globalLat, globalLong, globalLocationName);
                    
                        AnimatedSnackBar.rectangle(
                          'Sukses',
                          'Anda berhasil mengumpulkan sampah',
                          type: AnimatedSnackBarType.success,
                          brightness: Brightness.light,
                        ).show(
                          context,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ExchangeListPage()), 
                        );

                    } catch (e) {
                      print('Error during posting: $e');
                      AnimatedSnackBar.material(
                          'Gagal, coba lagi !',
                          type: AnimatedSnackBarType.error,
                        ).show(context);

                      setState(() {
                        controller.isLoading = false;
                      });
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ExchangeListPage()), 
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
                        'Kirim',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}