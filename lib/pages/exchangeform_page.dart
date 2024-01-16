import 'package:flutter/material.dart';
import 'exchange_page.dart';
import '../theme/app_colors.dart';

class ExchangeFormPage extends StatefulWidget {
  const ExchangeFormPage({Key? key}) : super(key: key);

  @override

  State<ExchangeFormPage> createState() => _ExchangeFormPageState();
}

class _ExchangeFormPageState extends State<ExchangeFormPage> {
  TextEditingController typeController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                labelText: 'Berat Sampah (kg)...',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ExchangePage()), 
                    );

                String type = typeController.text;
                String weight = weightController.text;

                typeController.clear();
                weightController.clear();
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