import 'package:flutter/material.dart';

extension TimeOfDayExt on TimeOfDay {
  String toFormattedString() {
    final String hour = this.hour.toString().padLeft(2, '0');
    final String minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
