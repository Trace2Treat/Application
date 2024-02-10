import 'package:flutter/material.dart';
import 'home_page.dart';

class ExchangeDetailPage extends StatefulWidget {
  final Map<String, dynamic> selectedData;

  const ExchangeDetailPage({Key? key, required this.selectedData}) : super(key: key);

  @override
  State<ExchangeDetailPage> createState() => _ExchangeDetailPageState();
}

class _ExchangeDetailPageState extends State<ExchangeDetailPage> {
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Detail Pengumpulan'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
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
                    buildRow('Tipe Sampah', widget.selectedData['trash_type']),
                    buildDivider(),
                    buildRow('Berat Sampah', '${widget.selectedData['trash_weight'].toString()} (kg)'),
                    buildDivider(),
                    buildRow('Koin Didapat', '${widget.selectedData['point'] ?? 'Pending'}'),
                    buildDivider(),
                    buildRow('Status', widget.selectedData['status']),
                    buildDivider(),
                    buildRow('Driver', widget.selectedData['driver_name'].isEmpty ? 'Pending' : widget.selectedData['driver_name']), 
                    buildDivider(),
                    buildRow('Tanggal', widget.selectedData['date']),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
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