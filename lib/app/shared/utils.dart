library service;

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:talker_flutter/talker_flutter.dart';

final formatterPrice = NumberFormat('#,###,##0.00');
final formatterItem = NumberFormat('#,###,##0.##');

final _random = Random();
int randomValue() {
  int min = 0;
  int max = 5;
  return min + _random.nextInt(max - min);
  // return int next(int min, int max) => min + _random.nextInt(max - min);
}

final talker = Talker(
  /// Your own observers to handle errors's exception's and log's
  /// like Crashlytics or Sentry observer
  // observers: [],
  settings: TalkerSettings(
    /// You can enable/disable all talker processes with this field
    enabled: !kReleaseMode,

    /// You can enable/disable saving logs data in history
    useHistory: true,

    /// Length of history that saving logs data
    maxHistoryItems: 100,

    /// You can enable/disable console logs
    useConsoleLogs: true,
  ),

  /// Setup your implementation of logger
  logger: TalkerLogger(),

  ///etc...
);
