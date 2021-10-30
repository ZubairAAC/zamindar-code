import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zamindar/model/location_service.dart';
import 'package:zamindar/view/CropChilds/cropdetial.dart';
import 'dart:math' as Math;

class addFarms extends StatefulWidget {
  addFarms({Key? key}) : super(key: key);

  @override
  _addFarmsState createState() => _addFarmsState();
}

class _addFarmsState extends State<addFarms> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Polygon> _polygons = HashSet<Polygon>();
  final Set<Polyline> _polyLines = HashSet<Polyline>();
  bool _drawPolygonEnabled = false;
  List<LatLng> _userPolyLinesLatLngList = [];
  bool _clearDrawing = false;
  int _lastXCoordinate = 0;
  int _lastYCoordinate = 0;

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
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
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
          _polygons.isEmpty && _polyLines.isEmpty
              ? InkWell(
                  onTap: () {
                    Get.to(() => CropDetails());
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Row(
                      children: [
                        Text(
                          "Next".tr,
                          style: TextStyle(
                              fontSize: 15, color: theme.primaryColorLight),
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
              : Container()
        ],
      ),
      body: Container(
        color: theme.backgroundColor,
        child: Stack(
          children: [
            GestureDetector(
              onPanUpdate: (_drawPolygonEnabled) ? _onPanUpdate : null,
              onPanEnd: (_drawPolygonEnabled) ? _onPanEnd : null,
              child: GoogleMap(
                polygons: _polygons,
                polylines: _polyLines,
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
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: h * 0.17,
                child: InkWell(
                  onTap: () {
                    _clearPolygons();
                    setState(() => _drawPolygonEnabled = !_drawPolygonEnabled);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: h * 0.20),
                    height: h * 0.07,
                    width: w * 0.07,
                    decoration: BoxDecoration(
                        color: theme.accentColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        _drawPolygonEnabled ? "Clear" : "Draw",
                        style: TextStyle(color: theme.cardColor),
                      ),
                    ),
                  ),
                )),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Select your farm on map by selecting edges of it",
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 0, bottom: 5),
                        child: Row(
                          children: [
                            Text(
                              "Your Location:",
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            UserLocation.street,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  _onPanUpdate(DragUpdateDetails details) async {
    // To start draw new polygon every time.
    if (_clearDrawing) {
      _clearDrawing = false;
      _clearPolygons();
    }

    if (_drawPolygonEnabled) {
      double x = 0.0, y = 0.0;
      if (Platform.isAndroid) {
        // It times in 3 without any meaning,
        // We think it's an issue with GoogleMaps package.
        x = details.globalPosition.dx * 3;
        y = details.globalPosition.dy * 3;
      } else if (Platform.isIOS) {
        x = details.globalPosition.dx;
        y = details.globalPosition.dy;
      }

      // Round the x and y.
      int xCoordinate = x.round();
      int yCoordinate = y.round();

      // Check if the distance between last point is not too far.
      // to prevent two fingers drawing.
      if (_lastXCoordinate != null && _lastYCoordinate != null) {
        var distance = Math.sqrt(Math.pow(xCoordinate - _lastXCoordinate, 2) +
            Math.pow(yCoordinate - _lastYCoordinate, 2));
        // Check if the distance of point and point is large.
        if (distance > 80.0) return;
      }

      // Cached the coordinate.
      _lastXCoordinate = xCoordinate;
      _lastYCoordinate = yCoordinate;

      ScreenCoordinate screenCoordinate =
          ScreenCoordinate(x: xCoordinate, y: yCoordinate);

      final GoogleMapController controller = await _controller.future;
      LatLng latLng = await controller.getLatLng(screenCoordinate);

      try {
        // Add new point to list.
        _userPolyLinesLatLngList.add(latLng);

        _polyLines.removeWhere(
            (polyline) => polyline.polylineId.value == 'user_polyline');
        _polyLines.add(
          Polyline(
            polylineId: PolylineId('user_polyline'),
            points: _userPolyLinesLatLngList,
            width: 2,
            color: Colors.blue,
          ),
        );
      } catch (e) {
        print(" error painting $e");
      }
      setState(() {});
    }
  }

  _onPanEnd(DragEndDetails details) async {
    // Reset last cached coordinate
    _lastXCoordinate = 0;
    _lastYCoordinate = 0;

    if (_drawPolygonEnabled) {
      _polygons
          .removeWhere((polygon) => polygon.polygonId.value == 'user_polygon');
      _polygons.add(
        Polygon(
          polygonId: PolygonId('user_polygon'),
          points: _userPolyLinesLatLngList,
          strokeWidth: 2,
          strokeColor: Colors.blue,
          fillColor: Colors.blue.withOpacity(0.4),
        ),
      );
      setState(() {
        _clearDrawing = true;
      });
    }
  }

  _clearPolygons() {
    setState(() {
      _polyLines.clear();
      _polygons.clear();
      _userPolyLinesLatLngList.clear();
    });
  }
}
