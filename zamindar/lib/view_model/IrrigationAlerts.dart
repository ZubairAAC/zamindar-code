import 'package:intl/intl.dart';
import 'package:zamindar/model/irrigationTime.dart';
import 'package:zamindar/view/parent/myhome.dart';

Future showBeforeIrrigationAlert() async {
  final today = DateFormat('EEEE').format(DateTime.now());
  final time = DateFormat("h").format(DateTime.now());
  if (today == irrigationTime.startDay) {
    if (time == irrigationTime.startTime!.split('')[0]) {
      HomeScreen().createState().showMyNotificationAsReminder();
    } else {
      return;
    }
  } else {
    print("before Alerts not matched");
    return;
  }
}

Future showAfterIrrigationAlert() async {
  final today = DateFormat('EEEE').format(DateTime.now());
  final time = DateFormat("h").format(DateTime.now());
  if (today == irrigationTime.endDay) {
    if (time == irrigationTime.endTime!.split('')[0]) {
      HomeScreen().createState().showMyNotificationAsAfterTime();
    } else {
      return;
    }
  } else {
    print(
        "Can't match ==> $today   with   ${irrigationTime.endDay}  && also can't match $time with  ${irrigationTime.endTime!.split('')[0]}");
    print("After Alerts not matched");
    return;
  }
}
