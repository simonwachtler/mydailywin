// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:my_daily_win/level.dart';

import 'package:tuple/tuple.dart';

void main() {
  test('calculation of level', () {
    expect(calculateLevels(0), Tuple2(1, .0));
    expect(calculateLevels(9), Tuple2(1, .9));
    expect(calculateLevels(10), Tuple2(2, .0));
    expect(calculateLevels(30), Tuple2(3, .0));
  });
}
