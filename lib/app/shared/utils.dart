library service;

import 'dart:html';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:talker_flutter/talker_flutter.dart';

final formatterPrice = NumberFormat('#,###,##0.00');
final formatterItem = NumberFormat('#,###,##0.##');

final _random = math.Random();
int randomValue() {
  int min = 0;
  int max = 5;
  return min + _random.nextInt(max - min);
  // return int next(int min, int max) => min + _random.nextInt(max - min);
}

randomColor() {
  return ui.Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
      .withOpacity(1.0);
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

report(
  String reportName,
  String output,
  String province,
  String amphure,
  String district,
  String name,
  String lastName,
  String position,
  String tel,
  String stationName,
  String moo,
  String agency,
  String affiliate,
) {
  // String output = 'pdf'; //pdf xlsx docx
  // String province = 'จันทบุรี';
  // String tambol = 'เกาะขวาง';
  String whereName = "";
  name.isNotEmpty ? whereName = "&NAME=$name" : whereName = "";
  String whereLastName = "";
  lastName.isNotEmpty
      ? whereLastName = "&LASTNAME=$lastName"
      : whereLastName = "";
  String wherePosition = "";
  position.isNotEmpty
      ? wherePosition = "&POSITION=$position"
      : wherePosition = "";
  String whereTel = "";
  tel.isNotEmpty ? whereTel = "&TEL=$tel" : whereTel = "";
  String whereStationName = "";
  stationName.isNotEmpty ? whereTel = "&INFO_NAME=$stationName" : whereTel = "";
  String whereMoo = "";
  moo.isNotEmpty ? whereMoo = "&MOO=$moo" : whereMoo = "";
  String whereAgency = "";
  agency.isNotEmpty ? whereAgency = "&AGENCY=$agency" : whereAgency = "";
  String whereAffiliate = "";
  agency.isNotEmpty
      ? whereAffiliate = "&AFFILIATE=$affiliate"
      : whereAffiliate = "";
  String whereLocation = "";
  // infoLocationController.text.isNotEmpty
  //     ? whereLocation =
  //         "&LOCATION=" + infoLocationController.text
  //     : whereLocation = "";
  String whereProvince = "";
  province.isNotEmpty
      ? whereProvince = "&PROVINCE=$province"
      : whereProvince = "";
  String whereAmphure = "";
  amphure.isNotEmpty ? whereAmphure = "&AMPHURE=$amphure" : whereAmphure = "";
  String whereTambol = "";
  district.isNotEmpty ? whereTambol = "&TAMBOL=$district" : whereTambol = "";
  String reportUrl =
      "https://d-network.ect.go.th/report/flow.html?_flowId=viewReportFlow&_flowId=viewReportFlow&ParentFolderUri=%2Freports%2FECT&reportUnit=%2Freports%2FECT%2F$reportName&standAlone=true&j_username=jasperadmin&j_password=jasperadmin&decorate=no&output=$output$whereProvince$whereName$whereMoo$whereLastName$wherePosition$whereTel$whereStationName$whereAgency$whereAffiliate$whereLocation$whereAmphure$whereTambol";
  window.open(reportUrl, "report");
}
