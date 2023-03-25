List<Module> listModule = [
  Module(
    id: 1,
    nameTH: "ภาพรวม",
    nameEn: "dashboard",
  ),
  Module(
    id: 2,
    nameTH: "ศส.ปชต.",
    nameEn: "station",
  ),
  Module(
    id: 3,
    nameTH: "กรรมการ",
    nameEn: "commiss",
  ),
  Module(
    id: 4,
    nameTH: "วิทยากรประชาธิปไตย",
    nameEn: "lectuter",
  ),
  Module(
    id: 5,
    nameTH: "หมู่บ้านไม่ขายเสียง",
    nameEn: "villagehosty",
  ),
  Module(
    id: 6,
    nameTH: "ตั้งค่า",
    nameEn: "setting",
  ),
];

Module getModuleByIndex(int index) {
  return listModule[index];
  // return listModule.where((element) => element.id == index).first;
}

class Module {
  int id;
  String nameTH;
  String nameEn;
  Module({
    required this.id,
    required this.nameTH,
    required this.nameEn,
  });
}
