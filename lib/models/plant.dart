import 'dart:convert';
import 'package:intl/intl.dart';

class Plant {
  String name;
  late String notes;
  DateTime date;
  late DateTime lastTimeWatered;
  late DateTime sendToFlower;

  Plant({required this.name, required this.date});

}