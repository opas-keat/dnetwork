library service;

import 'dart:math';

import 'package:intl/intl.dart';

final formatterPrice = NumberFormat('#,###,##0.00');
final formatterItem = NumberFormat('#,###,##0.##');

final _random = Random();
int randomValue() {
  int min = 0;
  int max = 5;
  return min + _random.nextInt(max - min);
  // return int next(int min, int max) => min + _random.nextInt(max - min);
}
