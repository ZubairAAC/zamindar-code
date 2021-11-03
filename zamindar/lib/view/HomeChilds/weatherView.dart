import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zamindar/model/location_service.dart';
import 'package:intl/intl.dart';
import 'package:zamindar/model/user.dart';
import 'package:zamindar/model/weather.dart';
import 'package:zamindar/view_model/sharedPrefForScreen.dart';
import 'package:zamindar/view_model/weatherApiCall.dart';

class WeatherView extends StatefulWidget {
  WeatherView({Key? key}) : super(key: key);

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  late Weather currentTemp;
  late List<Weather> sevenDay;
  bool viewAble = false;
  bool farmSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getweather();
    getfarm();
  }

  getfarm() async {
    final v = await getIsFarmSelectedFlag();
    setState(() {
      farmSelected = v;
    });

    print(farmSelected);
  }

  Future getweather() async {
    if (UserLocation.lat != null && UserLocation.long != null) {
      if (UserLocation.street != null) {
        setState(() {
          viewAble = true;
          print(UserLocation.street);
        });
        weatherApi(UserLocation.lat, UserLocation.long).then((value) {
          setState(() {});
        });
        setState(() {});
      }
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHieght = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: user.userlogin == true
          ? farmSelected == true
              ? viewAble
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          today(),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: Text(
                              "Next 7 days".tr,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: theme.accentColor),
                            ),
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 20, left: 10, right: 0),
                              child: NextSevenDays()),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Text("Error Getting your Farm Location.... "),
                            SizedBox(height: 25),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 100),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: screenHieght / 3,
                                    decoration: BoxDecoration(
                                      color: theme.accentColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Back",
                                        style:
                                            TextStyle(color: theme.cardColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]),
                    )
              : Center(
                  child: Text("Please Select Farm First".tr),
                )
          : Center(child: Text("Please Login to see".tr)),
    );
  }
}

class today extends StatelessWidget {
  const today({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('EEEE').format(DateTime.now());
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    String day = '$formattedDate';
    final theme = Theme.of(context);
    final screenHieght = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double finaltemp = WeatherForApi.temp;

    String temp = '${finaltemp.round()}';
    double finalvis = WeatherForApi.visibility / 1000;
    String vis = '${finalvis.round()}';
    String hum = '${WeatherForApi.humidity}';

    return SafeArea(
        child: Container(
      height: screenHieght * 0.65,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                // margin: EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 27,
                        width: 38,
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: theme.accentColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            color: theme.primaryColor,
                            size: 18,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Text(
            date.tr,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.055,
                color: theme.cardColor),
          ),
          SizedBox(height: 5),
          Text(
            day,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: theme.cardColor),
          ),
          SizedBox(height: 5),
          // Text("Today"),
          Container(
            child: WeatherForApi.img.isNotEmpty
                ? Image.asset(
                    WeatherForApi.img,
                    height: 140,
                    width: 140,
                  )
                : Container(),
          ),
          Spacer(),
          Text(
            WeatherForApi.cinditions.tr,
            style: TextStyle(
                color: theme.cardColor,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.045),
          ),
          SizedBox(height: 5),
          Container(
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 80,
                  width: 100,
                  child: Column(
                    children: [
                      Icon(
                        Icons.thermostat,
                        size: 30,
                        color: theme.cardColor,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Temperature".tr,
                        style: TextStyle(fontSize: screenWidth * 0.027),
                      ),
                      SizedBox(height: 5),
                      Text(
                        temp + "°",
                        style: TextStyle(color: theme.cardColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: 100,
                  child: Column(
                    children: [
                      Icon(
                        Icons.water,
                        size: 30,
                        color: theme.cardColor,
                      ),
                      SizedBox(height: 10),
                      Text("Humidity".tr,
                          style: TextStyle(fontSize: screenWidth * 0.027)),
                      SizedBox(height: 5),
                      Text(
                        hum + " %",
                        style: TextStyle(color: theme.cardColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: 100,
                  child: Column(
                    children: [
                      Icon(
                        Icons.remove_red_eye,
                        size: 30,
                        color: theme.cardColor,
                      ),
                      SizedBox(height: 10),
                      Text("Visibility".tr,
                          style: TextStyle(fontSize: screenWidth * 0.027)),
                      SizedBox(height: 5),
                      Text(
                        vis + " km",
                        style: TextStyle(color: theme.cardColor),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 5),
          Text(
            UserLocation.street == null
                ? "Weather in your farm"
                : UserLocation.street,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style:
                TextStyle(fontWeight: FontWeight.w900, color: theme.cardColor),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  size: 20,
                  color: theme.primaryColorLight,
                ),
                Text("Location",
                    style: TextStyle(color: theme.primaryColorLight)),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class NextSevenDays extends StatefulWidget {
  const NextSevenDays({Key? key}) : super(key: key);

  @override
  State<NextSevenDays> createState() => _NextSevenDaysState();
}

class _NextSevenDaysState extends State<NextSevenDays> {
  @override
  Widget build(BuildContext context) {
    List<Weather> sevenDay;

    final theme = Theme.of(context);
    final screenHieght = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHieght * 0.20,
      child: FutureBuilder<List<Weather>>(
        future: weatherApi(UserLocation.lat, UserLocation.long),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: theme.accentColor,
            ));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              // print(snapshot.data);
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = snapshot.data[index];
                  Weather seven = data;
                  var tempMax = seven.max;
                  var temMin = seven.min;
                  var finaltemperature =
                      "${temMin.round()}° " + "-" + "${tempMax.round()}°";
                  var img = seven.image;
                  var dis = seven.name;
                  var _currentDate = DateTime.now();
                  var tomorrow = DateTime(_currentDate.year, _currentDate.month,
                      _currentDate.day + 1);
                  var _dayFormatter = DateFormat('dd-MM-yyyy');
                  List weekend = [];
                  var today = DateFormat('EEEE').format(DateTime.now());
                  for (var i = 0; i < snapshot.data.length; i++) {
                    var date = tomorrow.add(Duration(days: i));
                    var myday = _dayFormatter.format(date);
                    weekend.add(myday);
                  }
                  print(seven.cinditions);

                  // print(dis);

                  return Container(
                    height: screenHieght * 0.15,
                    width: 100,
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Image.asset(
                          seven.image,
                          height: 70,
                          width: 70,
                        ),
                        SizedBox(height: 5),
                        Text(
                          finaltemperature,
                        ),
                        Text(
                          seven.cinditions.tr,
                          style: TextStyle(fontSize: 12),
                        ),
                        Spacer(),
                        SizedBox(height: 3),
                        Text(weekend[index], style: TextStyle(fontSize: 10))
                      ],
                    ),
                  );
                },
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}
