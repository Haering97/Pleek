import 'dart:convert';
import 'package:intl/intl.dart';

class Plant {
  String name;
  DateTime date;
  late DateTime lastTimeWatered;
  late DateTime sendToFlower;

  Plant({required this.name, required this.date});

}