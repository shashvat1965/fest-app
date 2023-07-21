import 'package:flutter/material.dart';

class MiscScreenController {
  static ValueNotifier<int> selectedTab = ValueNotifier(
      (DateTime.now().day <= 23 && DateTime.now().day >= 19)
          ? (DateTime.now().day)
          : 19);
}
