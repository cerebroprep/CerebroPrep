import 'package:flutter/foundation.dart';

class AppRefresh {
  static final ValueNotifier<int> refreshNotifier = ValueNotifier(0);

  static void refresh() {
    refreshNotifier.value++;
  }
}