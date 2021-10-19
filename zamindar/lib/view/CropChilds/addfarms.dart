import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zamindar/model/location_service.dart';
import 'package:zamindar/view/crops.dart';
import 'package:zamindar/view/parent/myhome.dart';
import 'package:zamindar/view_model/userLocation.dart';

class addFarms extends StatefulWidget {
  addFarms({Key? key}) : super(key: key);

  @override
  _addFarmsState createState() => _addFarmsState();
}

class _addFarmsState extends State<addFarms> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(UserLocation.lat, UserLocation.long),
    zoom: 94.4746,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: theme.accentColor)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Add Farms".tr,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColorLight),
            )
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.offAll(() => HomeScreen());
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Text(
                    "Next".tr,
                    style:
                        TextStyle(fontSize: 15, color: theme.primaryColorLight),
                  ),
                  SizedBox(width: 5),
                  SvgPicture.asset(
                    "asset/icons/right-arrow.svg",
                    height: 15,
                    width: 15,
                    color: theme.accentColor,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: theme.backgroundColor,
        child: Stack(
          children: [
            GoogleMap(
              mapToolbarEnabled: false,
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: theme.backgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                ))
          ],
        ),
      ),
    );
  }
}
