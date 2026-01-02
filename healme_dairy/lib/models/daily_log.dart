import 'package:flutter/material.dart';


class DailyLog {
  final int id;
  final DateTime date;
  final int itemId;
  final int value;

  DailyLog(this.id, this.date, this.itemId, this.value);
}