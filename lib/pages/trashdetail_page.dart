import 'package:flutter/material.dart';
import 'trashpickup_page.dart';
import '../theme/app_colors.dart';

class TrashDetailPage extends StatefulWidget {
  const TrashDetailPage({Key? key}) : super(key: key);

  @override

  State<TrashDetailPage> createState() => _TrashDetailPageState();
}

class _TrashDetailPageState extends State<TrashDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Penjemputan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              'Diva Ariani', 
              style: TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            Text(
              'Alamat Penjemputan', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              'Griya  Cibinong Indah, Kabupaten Bogor, Jawa Barat, Indonesia 16912', 
              style: TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            Text(
              'Jarak', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              '2km dari lokasi saya', 
              style: TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            Text(
              'Ongkos Kirim', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              'Rp 10.000', 
              style: TextStyle(
                fontSize: 12, 
              )
            ),
            const SizedBox(height: 10),
            Text(
              'Berat Sampah', 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 5),
            Text(
              '0.2 kg', 
              style: TextStyle(
                fontSize: 12, 
              )
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                // change status
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => const TrashPickupPage()
                  ), 
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Jemput Sampah', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ),
            )
          ],
        ),
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