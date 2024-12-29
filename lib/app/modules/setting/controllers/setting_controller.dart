import 'dart:async';

import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/services/address_service.dart';
import '../../../api/services/user_service.dart';
import '../../../data/models/users.dart';
import '../../../data/requests/user_service_request.dart';
import '../../../shared/utils.dart';

class SettingController extends GetxController {
  final logTitle = "SettingController";
  var isLoading = true.obs;

  List provinceSettingList = listProvinceSetting;

  final userName = TextEditingController(text: "");
  final password = TextEditingController(text: "");
  final firstName = TextEditingController(text: "");
  final lastName = TextEditingController(text: "");
  final idCard = TextEditingController(text: "");
  final selectedProvince = "".obs;
  final selectedUserType = "".obs;

  List userTypeList = [
    "ผู้ใช้งานทั่วไป",
    "ผู้ดูแลระบบ",
  ];

  final sampleTree = TreeNode.root(
    data: UserDetail(
      id: "root",
      userName: "",
      userPassword: "",
      firstName: "รายชื่อผู้ใช้งาน",
      lastName: "",
      idCard: "",
      province: "",
      icon: Icons.house,
      userType: "root",
      type: "root",
    ),
  );
  final provinceList = <String>[""].obs;

  final users = <Users>[].obs;
  final userIdForDelete = "".obs;

  @override
  void onInit() {
    super.onInit();
    talker.info('$logTitle onInit');
    listProvince();
  }

  delete() async {
    bool result = false;
    try {
      final response = await UserService().delete(userIdForDelete.value);
      talker.debug('response message : ${response?.message}');
      if (response?.code == "000") {
        userIdForDelete.value = "";
        result = true;
      } else {
        result = false;
      }
    } catch (e) {
      talker.error('$e');
      result = false;
    }
    return result;
  }

  save() async {
    talker.info('$logTitle:save:');
    isLoading.value = true;
    bool result = false;
    try {
      users.add(Users(
        id: 0,
        userName: userName.text,
        passwords: password.text,
        firstName: firstName.text,
        lastName: lastName.text,
        province: selectedProvince.value,
        userType: selectedUserType.value == "ผู้ใช้งานทั่วไป" ? "2" : "1",
        idCard: idCard.text,
      ));
      final response = await UserService().create(users.obs.value);
      if (response?.code == "000") {
        result = true;
      } else {
        result = false;
      }
    } catch (e) {
      talker.error('$e');
      result = false;
    }
    return result;
  }

  Future listUsers(String province) async {
    talker.info('$logTitle:listUsers');
    Map<String, String> qParams = {
      "offset": "0",
      "limit": "100",
      "province": province,
    };
    try {
      final result = await UserService().search(qParams);
      for (var item in result!.data!) {
        sampleTree.elementAt(province).add(
              TreeNode(
                key: item.id!.toString(),
                data: UserDetail(
                  id: item.id.toString(),
                  userName: item.userName,
                  userPassword: "********",
                  firstName: item.firstName,
                  lastName: item.lastName,
                  idCard: item.idCard,
                  province: item.province,
                  userType:
                      item.userType == "2" ? "ผู้ใช้งานทั่วไป" : "ผู้ดูแลระบบ",
                  icon: Icons.person,
                  type: "user",
                ),
              ),
            );
      }
    } catch (e) {
      talker.error('$e');
    }
  }

  Future listProvince() async {
    talker.info('$logTitle listProvince');
    // if (province.isEmpty) {
    //   province = addressController.selectedProvince.value;
    // }
    Map<String, String> qParams = {
      "offset": "0",
      "limit": "100",
      "province": "",
    };
    try {
      final result = await AddressService().listProvince(qParams);
      provinceList.clear();
      provinceList.add("");
      for (var item in result!.data!) {
        provinceList.add(item.pName!);
        sampleTree.add(
          TreeNode(
            key: item.pName!,
            data: UserDetail(
              id: item.id,
              userName: "",
              userPassword: "",
              firstName: item.pName!,
              lastName: "",
              idCard: "",
              province: "",
              userType: "",
              icon: Icons.home,
              type: "province",
            ),
          ),
        );
      }
      provinceList.refresh();
    } catch (e) {
      talker.error('$e');
    }
  }
}

class UserDetail {
  final String? id;
  final String? userName;
  final String? userPassword;
  final String? firstName;
  final String? lastName;
  final String? idCard;
  final String? province;
  final String? userType;
  final IconData? icon;
  final String? type;

  UserDetail({
    this.userName,
    this.firstName,
    this.icon,
    this.type,
    this.id,
    this.userPassword,
    this.lastName,
    this.idCard,
    this.province,
    this.userType,
  });
}

// extension on ExplorableNode {
//   Icon get icon {
//     if (isRoot) return const Icon(Icons.data_object);

//     if (this is FolderNode) {
//       if (isExpanded) return const Icon(Icons.folder_open);
//       return const Icon(Icons.folder);
//     }

//     if (this is FileNode) {
//       final file = data as File;
//       if (file.mimeType.startsWith("image")) return const Icon(Icons.image);
//       if (file.mimeType.startsWith("video")) {
//         return const Icon(Icons.video_file);
//       }
//     }

//     return const Icon(Icons.insert_drive_file);
//   }
// }

// abstract class Explorable {
//   final String name;
//   final DateTime createdAt;

//   Explorable(this.name) : createdAt = DateTime.now();

//   @override
//   String toString() => name;
// }

// class File extends Explorable {
//   final String mimeType;

//   File(super.name, {required this.mimeType});
// }

// class Folder extends Explorable {
//   Folder(super.name);
// }

// typedef ExplorableNode = TreeNode<Explorable>;

// typedef FileNode = TreeNode<File>;

// typedef FolderNode = TreeNode<Folder>;
