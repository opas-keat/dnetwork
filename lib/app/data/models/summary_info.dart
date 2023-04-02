List listSummaryInfo = [
  SummaryInfo(
    name: "ศส.ปชต.",
    nameEn: "station",
    value: 99999,
  ),
  SummaryInfo(
    name: "กรรมการ",
    nameEn: "commiss",
    value: 99999,
  ),
  SummaryInfo(
    name: "วิทยากร",
    nameEn: "lectuter",
    value: 99999,
  ),
  SummaryInfo(
    name: "หมู่บ้านไม่ขายเสียง",
    nameEn: "villagehosty",
    value: 99999,
  ),
];

class SummaryInfo {
  String name;
  String nameEn;
  int value;
  SummaryInfo({
    required this.name,
    required this.nameEn,
    required this.value,
  });
}
