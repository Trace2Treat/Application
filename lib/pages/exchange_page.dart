import 'package:flutter/material.dart';
import 'exchangeform_page.dart';
import 'exchangedetail_page.dart';
import '../theme/app_colors.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({Key? key}) : super(key: key);

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Tukar Sampah'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ExchangeFormPage()), 
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
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(56),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 36, minWidth: 88),
                    alignment: Alignment.center,
                    child: const Text(
                      'Tukar',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                                child: Row(
                                  children: [
                    Image.asset('assets/trash.png', height: 16, width: 16),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Selasa, 16 Januari 2024', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Point earned: Pending'),
                        Text('Status: Pending')
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ExchangeDetailPage()), 
                        );
                      }, 
                      icon: Icon(Icons.arrow_right_alt_rounded)
                    )
                  ]
                )
              )
            ),
            const SizedBox(height: 5),
            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                                child: Row(
                                  children: [
                    Image.asset('assets/trash.png', height: 16, width: 16),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Senin, 15 Januari 2024', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Point earned: 200'),
                        Text('Status: Received')
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ExchangeDetailPage()), 
                        );
                      }, 
                      icon: Icon(Icons.arrow_right_alt_rounded)
                    )
                  ]
                )
              )
            ),
            const SizedBox(height: 5),
            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                                child: Row(
                                  children: [
                    Image.asset('assets/trash.png', height: 16, width: 16),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Jumat, 12 Januari 2024', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Point earned: 500'),
                        Text('Status: Finished')
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ExchangeDetailPage()), 
                        );
                      }, 
                      icon: Icon(Icons.arrow_right_alt_rounded)
                    )
                  ]
                )
              )
            ),
            const SizedBox(height: 5),
            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                                child: Row(
                                  children: [
                    Image.asset('assets/trash.png', height: 16, width: 16),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Kamis, 11 Januari 2024', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Point earned: 500'),
                        Text('Status: Finished')
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ExchangeDetailPage()), 
                        );
                      }, 
                      icon: Icon(Icons.arrow_right_alt_rounded)
                    )
                  ]
                )
              )
            ),
            const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}