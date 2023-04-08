import 'package:get/get.dart';

List listProvinceSetting = [
  ProvinceSetting(
    id: 1,
    name: "1",
    isExpanded: false.obs,
  ),
];

class ProvinceSetting {
  ProvinceSetting({this.id, this.name, this.isExpanded});
  int? id;
  String? name;
  RxBool? isExpanded;
}

class User {
  int? id;
  String? name;
}
