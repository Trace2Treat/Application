import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ExchangeDetailPage extends StatefulWidget {
  const ExchangeDetailPage({Key? key}) : super(key: key);

  @override

  State<ExchangeDetailPage> createState() => _ExchangeDetailPageState();
}

class _ExchangeDetailPageState extends State<ExchangeDetailPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Penjemputan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.white,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildRow('Tipe Sampah','Plastik'),
                                  buildDivider(),
                                  buildRow('Berat Sampah', '0.2 kg'),
                                  buildDivider(),
                                  buildRow('Poin Didapat', '200'),
                                  buildDivider(),
                                  buildRow('Status', 'In Pick Up'),
                                  buildDivider(),
                                  buildRow('Driver', 'Abang'),
                                  buildDivider(),
                                  buildRow('Tanggal', '2024-01-16'),
                                ],
                              )
                          ),
          ],
        ),
      ),
    );
  }

   Widget buildRow(String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text1, style: const TextStyle(color: Colors.grey)),
          Text(text2, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return const Divider(
      height: 0.2,
      color: Colors.grey,
    );
  }
}