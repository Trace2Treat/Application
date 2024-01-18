import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:trace2treat/pages/foodordersuccess_page.dart';
import 'home_page.dart';
import '../utils/globals.dart';
import '../theme/app_colors.dart';

class FoodOrderQrPage extends StatefulWidget {
  const FoodOrderQrPage({Key? key}) : super(key: key);

  @override
  State<FoodOrderQrPage> createState() => _FoodOrderQrPageState();
}

class _FoodOrderQrPageState extends State<FoodOrderQrPage> {
  Future<void> _scanBarcode() async {
    String barcodeResult = await FlutterBarcodeScanner.scanBarcode(
      '#FF0000',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OrderSuccessPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
        title: Text('Payment'),
        centerTitle: true,
      ),
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              width: 360,
              height: 800,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
            ),
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 70),
                    Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Image(
                                  width: 200,
                                  image: AssetImage("assets/qr.png"),
                                ),
                                const SizedBox(height: 80),
                                ElevatedButton(
                                  onPressed: _scanBarcode,
                                  child: Text('Scan QR Code', style: TextStyle(fontSize: 12)),
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColors.primary,
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    elevation: 4,
                                    minimumSize: const Size(130, 48),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}