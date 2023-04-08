import 'package:get/get.dart';

import '../../shared/utils.dart';

List listProvinceSetting = [
  ProvinceSetting(
    id: 1,
    name: "กรุงเทพมหานคร",
    isExpanded: false.obs,
    users: generateUsers(randomValue()),
  ),
  ProvinceSetting(
    id: 2,
    name: "นนทบุรี",
    isExpanded: false.obs,
    users: generateUsers(randomValue()),
  ),
];

class ProvinceSetting {
  ProvinceSetting({
    this.id,
    this.name,
    this.isExpanded,
    this.users,
  });
  int? id;
  String? name;
  RxBool? isExpanded;
  List<User>? users;
}

class User {
  User({
    this.id,
    this.name,
  });
  int? id;
  String? name;
}

List<User> generateUsers(int numberOfItems) {
  return List<User>.generate(numberOfItems, (int index) {
    return User(
      id: index + 1,
      name: 'ผู้ใช้งาน ${index + 1}',
    );
  });
}
