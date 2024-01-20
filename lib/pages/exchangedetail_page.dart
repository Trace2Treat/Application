import 'package:flutter/material.dart';

class ExchangeDetailPage extends StatefulWidget {
  final Map<String, dynamic> selectedData;

  const ExchangeDetailPage({Key? key, required this.selectedData}) : super(key: key);

  @override
  _ExchangeDetailPageState createState() => _ExchangeDetailPageState();
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
                  buildRow('Tipe Sampah', widget.selectedData['trash_type']),
                  buildDivider(),
                  buildRow('Berat Sampah', '${widget.selectedData['trash_weight'].toString()} (kg)'),
                  buildDivider(),
                  buildRow('Poin Didapat', '${widget.selectedData['point'] ?? 'Pending'}'),
                  buildDivider(),
                  buildRow('Status', widget.selectedData['status']),
                  buildDivider(),
                  buildRow('Driver', widget.selectedData['driver_id'].toString() == 'null' ? 'Pending' : widget.selectedData['driver_id'].toString()), 
                  buildDivider(),
                  buildRow('Tanggal', widget.selectedData['date']),
                ],
              ),
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