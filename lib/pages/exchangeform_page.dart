import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'dart:async';
import 'exchange_page.dart';
import '../theme/app_colors.dart';
import '../api/trash_service.dart';

class ExchangeFormPage extends StatefulWidget {
  // final double myLatitude;
  // final double myLongitude;
  const ExchangeFormPage({
    //required this.myLatitude, required this.myLongitude, 
    Key? key}) : super(key: key);

  @override

  State<ExchangeFormPage> createState() => _ExchangeFormPageState();
}

class _ExchangeFormPageState extends State<ExchangeFormPage> {
  TrashService controller = TrashService();
  TextEditingController typeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String message = 'Location';
  double myLatitude = 0.0;
  double myLongitude = 0.0;
  String myLocation = '';

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await geolocator.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    geolocator.LocationPermission permission = await geolocator.Geolocator.checkPermission();
    if (permission == geolocator.LocationPermission.denied) {
      permission = await geolocator.Geolocator.requestPermission();
      if (permission == geolocator.LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == geolocator.LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cant request');
    }

    final position = await geolocator.Geolocator.getCurrentPosition();
    myLatitude = position.latitude;
    myLongitude = position.longitude;
    await getLocationName();

    setState(() {
      message = 'Latitude $myLatitude, Longitude: $myLongitude';
    });

    return await geolocator.Geolocator.getCurrentPosition();
  }

  Future<String> getLocationName() async {
    double latitude = myLatitude;
    double longitude = myLongitude;

    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      String locationName = placemark.name ?? "";
      String thoroughfare = placemark.thoroughfare ?? "";
      String subLocality = placemark.subLocality ?? "";
      String locality = placemark.locality ?? "";
      String administrativeArea = placemark.administrativeArea ?? "";
      String country = placemark.country ?? "";
      String postalCode = placemark.postalCode ?? "";

      String address = "$locationName $thoroughfare $subLocality $locality $administrativeArea $country $postalCode";

      myLocation = address;
      return address;
    } else {
      myLocation = "Location not found";
      return "Location not found";
    }
  }

  // void _liveLocation() {
  //   geolocator.LocationSettings locationSettings = 
  //     const geolocator.LocationSettings(accuracy: geolocator.LocationAccuracy.high, distanceFilter: 1000);

  //   geolocator.Geolocator.getPositionStream(locationSettings: locationSettings).listen((geolocator.Position position) {
  //     double targetLatitude1 = -6.520107;
  //     double targetLongitude1 = 106.830266;
  //     double area1a10003000 = geolocator.Geolocator.distanceBetween(position.latitude, position.longitude, targetLatitude1, targetLongitude1);

  //     double targetLatitude2 = -6.520100;
  //     double targetLongitude2 = 106.831998;
  //     double finishedwarehouse = geolocator.Geolocator.distanceBetween(position.latitude, position.longitude, targetLatitude2, targetLongitude2);

  //     if (area1a10003000 <= 50 || finishedwarehouse <= 50) {
  //       globalLat = position.latitude.toString();
  //       globalLong = position.longitude.toString();

  //       setState(() {
  //         message = 'Latitude $globalLat, Longitude: $globalLong';
  //       });
  //     } else {
  //       setState(() {
  //         message = 'Outside the allowed area';
  //         globalLat = '';
  //         globalLong = '';
  //         globalLocationName = AppLocalizations(globalLanguage).translate("outsideArea");
  //       });
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    //_liveLocation();
  }

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
                  onPressed: () async {

                    setState(() {
                      controller.isLoading = true;
                    });

                    try {
                      await controller.postTrashRequest(typeController.text, weightController.text, '-6.5900593', '106.8012695', 'example.photo.png');
                    
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
                          MaterialPageRoute(builder: (context) => const ExchangePage()), 
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
                      MaterialPageRoute(builder: (context) => const ExchangePage()), 
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