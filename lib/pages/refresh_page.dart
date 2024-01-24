import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'exchangeform_page.dart';
import 'home_page.dart';
import 'registresto_page.dart';
import '../themes/app_colors.dart';
import '../utils/globals.dart';

class RefreshTrashForm extends StatefulWidget {
  const RefreshTrashForm({Key? key}) : super(key: key);

  @override
  State<RefreshTrashForm> createState() => _RefreshTrashFormState();
}

class _RefreshTrashFormState extends State<RefreshTrashForm> {
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

      setState(() {
        globalLat = myLatitude.toString();
        globalLong = myLongitude.toString();
        globalLocationName = address;
      });
      return address;
    } else {
      myLocation = "Location not found";
      return "Location not found";
    }
  }

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      _getCurrentLocation().then((value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ExchangeFormPage(),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primary)
        ),
      ),
    );
  }
}

class RefreshHomePage extends StatefulWidget {
  const RefreshHomePage({Key? key}) : super(key: key);

  @override
  State<RefreshHomePage> createState() => _RefreshHomePageState();
}

class _RefreshHomePageState extends State<RefreshHomePage> {
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

      setState(() {
        globalLat = myLatitude.toString();
        globalLong = myLongitude.toString();
        globalLocationName = address;
      });
      return address;
    } else {
      myLocation = "Location not found";
      return "Location not found";
    }
  }

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      _getCurrentLocation().then((value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primary)
        ),
      ),
    );
  }
}

class RefreshRegistForm extends StatefulWidget {
  const RefreshRegistForm({Key? key}) : super(key: key);

  @override
  State<RefreshRegistForm> createState() => _RefreshRegistFormState();
}

class _RefreshRegistFormState extends State<RefreshRegistForm> {
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

      setState(() {
        globalLat = myLatitude.toString();
        globalLong = myLongitude.toString();
        globalLocationName = address;
      });
      return address;
    } else {
      myLocation = "Location not found";
      return "Location not found";
    }
  }

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      _getCurrentLocation().then((value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ExchangeFormPage(),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primary)
        ),
      ),
    );
  }
}