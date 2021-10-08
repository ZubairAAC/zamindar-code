// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/instance_manager.dart';

// class weatherScreen extends StatefulWidget {
//   weatherScreen({Key? key}) : super(key: key);

//   @override
//   _weatherScreenState createState() => _weatherScreenState();
// }

// class _weatherScreenState extends State<weatherScreen> {
//   String location = 'Null, Press Button';
//   String Address = 'search';
//   getMylocation() async {
//     Position position = await _getGeoLocationPosition();
//     location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
//     GetAddressFromLatLong(position);
//   }

//   Future<Position> _getGeoLocationPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }

//   Future<void> GetAddressFromLatLong(Position position) async {
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     print(placemarks);
//     Placemark place = placemarks[0];
//     Address =
//         '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
//     setState(() {
//       // location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       body: FutureBuilder(
//         future: _getGeoLocationPosition(),
//         initialData: getMylocation(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(
//                 color: theme.accentColor,
//               ),
//             );
//           } else if (snapshot.connectionState == ConnectionState.done) {
//             return Center(
//               child: Text(location),
//             );
//           } else {
//             return Center(
//               child: Text("Something went wrong"),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
