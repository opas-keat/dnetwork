import 'package:flutter/material.dart';

List<Module> listModule = [
  Module(
    id: 1,
    nameTH: "หน้าจอหลัก",
    nameEn: "dashboard",
    icon: Icons.dashboard_sharp,
  ),
  Module(
    id: 2,
    nameTH: "ศส.ปชต.",
    nameEn: "station",
    icon: Icons.account_balance_sharp,
  ),
  Module(
    id: 3,
    nameTH: "กรรมการ",
    nameEn: "commiss",
    icon: Icons.account_box_sharp,
  ),
  Module(
    id: 4,
    nameTH: "สมาชิก",
    nameEn: "member",
    icon: Icons.account_box_sharp,
  ),
  Module(
    id: 5,
    nameTH: "เครือข่าย",
    nameEn: "network",
    icon: Icons.account_box_sharp,
  ),
  Module(
    id: 6,
    nameTH: "การฝึกอบรม",
    nameEn: "training",
    icon: Icons.laptop_sharp,
  ),
  Module(
    id: 7,
    nameTH: "งบประมาณ รายรับ-รายจ่าย",
    nameEn: "budget",
    icon: Icons.book_sharp,
  ),
  Module(
    id: 8,
    nameTH: "หมู่บ้าน วิถี ประชาธิปไตย",
    nameEn: "villagehosty",
    icon: Icons.holiday_village_sharp,
  ),
  Module(
    id: 9,
    nameTH: "วิทยากรประชาธิปไตย",
    nameEn: "lectuter",
    icon: Icons.three_p_sharp,
  ),
  Module(
    id: 10,
    nameTH: "ตั้งค่าผู้ใช้งาน",
    nameEn: "setting",
    icon: Icons.settings,
  ),
  Module(
    id: 11,
    nameTH: "แจ้งปัญหาการใช้งาน",
    nameEn: "reportproblem",
    icon: Icons.bug_report_sharp,
  ),
  Module(
    id: 12,
    nameTH: "รายการปัญหา",
    nameEn: "listproblem",
    icon: Icons.report_problem_sharp,
  ),
];

Module getModuleByIndex(int index) {
  return listModule[index];
  // return listModule.where((element) => element.id == index).first;
}

Module getModuleByNameEn(String nameEn) {
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
  Module({
    required this.id,
    required this.nameTH,
    required this.nameEn,
    required this.icon,
  });
}
