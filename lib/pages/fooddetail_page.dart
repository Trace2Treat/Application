import 'package:flutter/material.dart';

class FoodDetailPage extends StatelessWidget {
  final Map<String, dynamic> selectedData;

  const FoodDetailPage({Key? key, required this.selectedData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              selectedData['thumb'], 
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              'Nama: ${selectedData['name']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Deskripsi: ${selectedData['description']}'),
            Text('Stok: ${selectedData['stock'] ?? 0}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // edit page
              },
              child: const Text('Edit Menu'),
            ),
          ],
        ),
      ),
    );
  }
}