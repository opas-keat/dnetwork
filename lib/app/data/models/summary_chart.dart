import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../shared/constant.dart';

List<SummaryChart> summaryBudgetChart = [
  SummaryChart(
    icon: Icons.edit_document,
    color: primaryColor,
    name: "ภารกิจดำเนินโครงการ",
    value: 7,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFF26E5FF),
    name: "งบสนับสนุนการดำเนินงาน",
    value: 0,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFFFFCF26),
    name: "งานช่วยเหลือ",
    value: 0,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFFEE2727),
    name: "งบบำรุงหน่วยงาน",
    value: 0,
  ),
];

List<SummaryChart> summaryTrainingChart = [
  SummaryChart(
    icon: Icons.edit_document,
    color: primaryColor,
    name: "การอบรม ศส.ปชต.",
    value: 800,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFF26E5FF),
    name: "การอบรมของภาครัฐ",
    value: 8,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFFFFCF26),
    name: "การอบรมของสำนักงาน กกต.",
    value: 80,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFFEE2727),
    name: "การอบรมการเลือกตั้ง",
    value: 0,
  ),
];

List<SummaryChart> summaryLectuterChart = [
  SummaryChart(
    icon: Icons.edit_document,
    color: primaryColor,
    name: "สำนักงานส่งเสริมการศึกษานอกระบบและการศึกษาตามอัธยาศัย",
    value: 100,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFF26E5FF),
    name: "วิทยากรระดับจังหวัด",
    value: 100,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFFFFCF26),
    name: "วิทยากรของรัฐ กรมการปกครอง แระทรวงมหาดไทย",
    value: 2800,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFFEE2727),
    name: "วิทยากรของรัฐ กรมสนับสนุนบริการสุขภาพ",
    value: 300,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color.fromARGB(255, 238, 25, 192),
    name: "วิทยากรของรัฐ กรมการพัฒนาชุมชน",
    value: 300,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color.fromARGB(255, 39, 238, 59),
    name: "วิทยากรของรัฐ กรมกิจการผู้สูงอายุ",
    value: 400,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color.fromARGB(255, 122, 39, 238),
    name: "วิทยากรของรัฐ กรมส่งเสริมการปกครองท้องถิ่น",
    value: 250,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color.fromARGB(255, 49, 39, 238),
    name: "วิทยากรของรัฐ",
    value: 250,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color.fromARGB(255, 49, 39, 238),
    name: "สำนักงานส่งเสริมการศึกษานอกระบบและการศึกษาตามอัธยาศัย",
    value: 20999,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color.fromARGB(255, 39, 238, 228),
    name: "วิทยากร ส่วนกลาง กกต.",
    value: 250,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color.fromARGB(255, 238, 142, 39),
    name: "วิทยากร ส่วนงาน ศศ.ปชต.",
    value: 250,
  ),
];

List<SummaryChart> summaryVillageChart = [
  SummaryChart(
    icon: Icons.edit_document,
    color: primaryColor,
    name: "จังหวัด",
    value: 1,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFF26E5FF),
    name: "อำเภอ",
    value: 20,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFFFFCF26),
    name: "ตำบล",
    value: 49979,
  ),
];

List<SummaryChart> summaryNetworkChart = [
  SummaryChart(
    icon: Icons.edit_document,
    color: primaryColor,
    name: "ประธานกรรมการ",
    value: 2,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFF26E5FF),
    name: "รองประธานกรรมการ",
    value: 2,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFFFFCF26),
    name: "กรรมการ",
    value: 3,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFFEE2727),
    name: "กรรมการ/นายทะเบียน",
    value: 0,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color.fromARGB(255, 238, 25, 192),
    name: "กรรมการ/เหรัญญิก",
    value: 2,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color.fromARGB(255, 39, 238, 59),
    name: "กรรมการ/ประชาสัมพันธ์",
    value: 0,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color.fromARGB(255, 122, 39, 238),
    name: "กรรมการ/เลขานุการ",
    value: 2,
  ),
];

List<SummaryChart> summaryMemberChart = [
  SummaryChart(
    icon: Icons.edit_document,
    color: primaryColor,
    name: "ประธานกรรมการ",
    value: 1000,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFF26E5FF),
    name: "รองประธานกรรมการ",
    value: 1000,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFFFFCF26),
    name: "กรรมการ",
    value: 1500,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFFEE2727),
    name: "กรรมการ/นายทะเบียน",
    value: 200,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color.fromARGB(255, 238, 25, 192),
    name: "กรรมการ/เหรัญญิก",
    value: 200,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color.fromARGB(255, 39, 238, 59),
    name: "กรรมการ/ประชาสัมพันธ์",
    value: 100,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color.fromARGB(255, 122, 39, 238),
    name: "กรรมการ/เลขานุการ",
    value: 1000,
  ),
];

List<SummaryChart> summaryCommissChart = [
  SummaryChart(
    icon: Icons.edit_document,
    color: primaryColor,
    name: "ประธานกรรมการ",
    value: 10000,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFF26E5FF),
    name: "รองประธานกรรมการ",
    value: 10000,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFFFFCF26),
    name: "กรรมการ",
    value: 50000,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFFEE2727),
    name: "กรรมการ/นายทะเบียน",
    value: 2000,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color.fromARGB(255, 238, 25, 192),
    name: "กรรมการ/เหรัญญิก",
    value: 3000,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color.fromARGB(255, 39, 238, 59),
    name: "กรรมการ/ประชาสัมพันธ์",
    value: 3000,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color.fromARGB(255, 122, 39, 238),
    name: "กรรมการ/เลขานุการ",
    value: 10000,
  ),
];

List<SummaryChart> summaryStationChart = [
  SummaryChart(
    icon: Icons.edit_document,
    color: primaryColor,
    name: "การอบรม ศส.ปชต.",
    value: 800,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFF26E5FF),
    name: "การอบรมของภาครัฐ",
    value: 8,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFFFFCF26),
    name: "การอบรมของสำนักงาน กกต.",
    value: 80,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFFEE2727),
    name: "การอบรมการเลือกตั้ง",
    value: 0,
  ),
];

List<SummaryChart> summaryDashboardChart = [
  SummaryChart(
    icon: Icons.edit_document,
    color: primaryColor,
    name: "การอบรม ศส.ปชต.",
    value: 800,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFF26E5FF),
    name: "การอบรมของภาครัฐ",
    value: 1000,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFFFFCF26),
    name: "การอบรมของสำนักงาน กกต.",
    value: 1080,
  ),
  SummaryChart(
    icon: Icons.edit_document,
    color: const Color(0xFFEE2727),
    name: "การอบรมการเลือกตั้ง",
    value: 8,
  ),
];

int getSummaryValueFromListSummaryChart(List<SummaryChart> summaryChart) {
  return summaryChart.fold(0, (sum, item) => sum + item.value);
}

List<PieChartSectionData> transformToPieChartData(
  List<SummaryChart> summaryChart,
) {
  List<PieChartSectionData> pieChartSelectionDatas = [];
  for (int i = 0; i < summaryChart.length; i++) {
    pieChartSelectionDatas.add(PieChartSectionData(
      color: summaryChart[i].color,
      value: summaryChart[i].value.toDouble(),
      showTitle: false,
      radius: 25 - (i * 3),
    ));
  }
  return pieChartSelectionDatas;
}

class SummaryChart {
  IconData icon;
  Color color;
  String name;
  int value;
  SummaryChart({
    required this.icon,
    required this.color,
    required this.name,
    required this.value,
  });
}
