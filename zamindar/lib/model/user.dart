import 'dart:io';

class user {
  static String name = '';
  static String phone = '';
  static String image = '';
  static String gender = '';
  static bool userlogin = false;
  static String otp = '';
  final String intialLocation;
  user({required this.intialLocation});
  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      "intialLocation": intialLocation,
    };
  }
}
