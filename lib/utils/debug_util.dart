import 'dart:developer';

import 'package:flutter/foundation.dart';

class DebugUtil {
  logDebug(String logData, {String? logName}) {
    if (kDebugMode) {
      return log(logData, name: logName!);
    }
  }
}
