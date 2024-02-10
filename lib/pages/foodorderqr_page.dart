import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'foodordersuccess_page.dart';
import 'home_page.dart';
import '../themes/app_colors.dart';
import '../services/transaction_service.dart';

class FoodOrderQrPage extends StatefulWidget {
  const FoodOrderQrPage({Key? key}) : super(key: key);

  @override
  State<FoodOrderQrPage> createState() => _FoodOrderQrPageState();
}

class _FoodOrderQrPageState extends State<FoodOrderQrPage> {
  final TransactionService controller = TransactionService();

  Future<void> _scanBarcode() async {
    String barcodeResult = await FlutterBarcodeScanner.scanBarcode(
      '#FF0000',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );

    if (barcodeResult.isNotEmpty) {
      try {
        await controller.payTransaction(barcodeResult);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderSuccessPage(),
          ),
        );
      } catch (error) {
        print('Payment failed: $error');
      }
    }
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
          automaticallyImplyLeading: false,
          title: const Text('PAYMENT', style: TextStyle(fontWeight: FontWeight.bold)),
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
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.primary,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              minimumSize: const Size(130, 48),
                            ),
                            child: const Text('Scan QR Code', style: TextStyle(fontSize: 12)),
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