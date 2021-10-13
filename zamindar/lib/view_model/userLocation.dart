import 'package:location/location.dart';
import 'package:zamindar/model/location_service.dart';
import 'package:flutter/material.dart';

class locationFinder extends StatefulWidget {
  locationFinder({Key? key}) : super(key: key);

  @override
  _locationFinderState createState() => _locationFinderState();
  // void printSample(){
  //       locationFinder().createState().locationService();
  //   }
}

class _locationFinderState extends State<locationFinder> {
  @override
  Future<void> locationService() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionLocation;
    LocationData _locData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionLocation = await location.hasPermission();
    if (_permissionLocation == PermissionStatus.denied) {
      _permissionLocation = await location.requestPermission();
      if (_permissionLocation != PermissionStatus.granted) {
        return;
      }
    }

    _locData = await location.getLocation();

    UserLocation.lat = _locData.latitude!;
    UserLocation.long = _locData.longitude!;

    print("location is ${UserLocation.lat} + ${UserLocation.long}");
  }

  Widget build(BuildContext context) {
    return Container();
  }
}
