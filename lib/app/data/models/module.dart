import 'package:flutter/material.dart';

import '../../routes/app_pages.dart';

List<Module> listModule = [
  Module(
    id: 1,
    nameTH: "หน้าจอหลัก",
    nameEn: "dashboard",
    icon: Icons.dashboard_sharp,
    url: Routes.DASHBOARD,
  ),
  Module(
    id: 2,
    nameTH: "ศส.ปชต.",
    nameEn: "station",
    icon: Icons.account_balance_sharp,
    url: Routes.STATION,
  ),
  Module(
    id: 3,
    nameTH: "กรรมการ",
    nameEn: "commiss",
    icon: Icons.account_box_sharp,
    url: Routes.COMMISS,
  ),
  Module(
    id: 4,
    nameTH: "สมาชิก",
    nameEn: "member",
    icon: Icons.supervisor_account_sharp,
    url: Routes.MEMBER,
  ),
  Module(
    id: 5,
    nameTH: "ภาคีเครือข่าย",
    nameEn: "network",
    icon: Icons.account_tree_sharp,
    url: Routes.NETWORK,
  ),
  Module(
    id: 6,
    nameTH: "หมู่บ้าน วิถี ประชาธิปไตย",
    nameEn: "village",
    icon: Icons.holiday_village_sharp,
    url: Routes.VILLAGEHOSTY,
  ),
  Module(
    id: 7,
    nameTH: "วิทยากรประชาธิปไตย",
    nameEn: "lectuter",
    icon: Icons.three_p_sharp,
    url: Routes.LECTUTER,
  ),
  Module(
    id: 8,
    nameTH: "การฝึกอบรม",
    nameEn: "training",
    icon: Icons.laptop_sharp,
    url: Routes.TRAINING,
  ),
  Module(
    id: 9,
    nameTH: "งบประมาณ รายรับ-รายจ่าย",
    nameEn: "budget",
    icon: Icons.book_sharp,
    url: Routes.BUDGET,
  ),
  Module(
    id: 10,
    nameTH: "ตั้งค่าผู้ใช้งาน",
    nameEn: "setting",
    icon: Icons.settings,
    url: Routes.SETTING,
  ),
  Module(
    id: 11,
    nameTH: "แจ้งปัญหาการใช้งาน",
    nameEn: "incident",
    icon: Icons.bug_report_sharp,
    url: Routes.INCIDENT,
  ),
  // Module(
  //   id: 12,
  //   nameTH: "รายการปัญหา",
  //   nameEn: "listproblem",
  //   icon: Icons.report_problem_sharp,
  //   url: Routes.LIST_REPORT,
  // ),
];

Module getModuleByIndex(int index) {
  return listModule[index];
  // return listModule.where((element) => element.id == index).first;
}

Module getModuleByNameEn(String? nameEn) {
  return listModule.where((element) => element.nameEn == nameEn).first;
}

final Map<String, String> optionModuleSelected = {
  '2': 'ศส.ปชต.',
  '3': 'กรรมการ',
  '4': 'วิทยากรประชาธิปไตย',
  '5': 'หมู่บ้านไม่ขายเสียง',
};

class Module {
  int id;
  String nameTH;
  String nameEn;
  IconData icon;
  String url;
  Module({
    required this.id,
    required this.nameTH,
    required this.nameEn,
    required this.icon,
    required this.url,
  });
}
