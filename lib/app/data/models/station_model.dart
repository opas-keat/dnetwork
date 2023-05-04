List<StationModel> listStationModel = [
  StationModel(
    name: "ศูนย์ส่งเสริมพัฒนาประชาธิปไตยและการเลือกตั้งแขวงเสนานิคม สาขา 8",
  ),
];

class StationModel {
  String? name, locaion, province, amphure, tambol, facebook, process;
  StationModel({
    this.name,
    this.locaion,
    this.province,
    this.amphure,
    this.tambol,
    this.facebook,
    this.process,
  });
}
