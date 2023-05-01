List listVillageStatisticsData = [
  VillageStatisticsData(
    name: "ลาดยาว 1",
    no: "125/258",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงลาดยาว",
    total: 10,
  ),
  VillageStatisticsData(
    name: "จันทรเกษม",
    no: "88/888",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงจันทรเกษม",
    total: 2000,
  ),
  VillageStatisticsData(
    name: "จอมพล",
    no: "9",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงจอมพล",
    total: 500,
  ),
  VillageStatisticsData(
    name: "จตุจักร",
    no: "452/88",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงจตุจักร",
    total: 521,
  ),
  VillageStatisticsData(
    name: "เสนานิคม",
    no: "585/12",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงเสนานิคม",
    total: 555,
  ),
  VillageStatisticsData(
    name: "เสนานิคม 7",
    no: "121/258",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงเสนานิคม",
    total: 574,
  ),
  VillageStatisticsData(
    name: "เสนานิคม 8",
    no: "45/33",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงเสนานิคม",
    total: 745,
  ),
];

class VillageStatisticsData {
  String? name, no, address;
  int? total;
  VillageStatisticsData({
    this.name,
    this.no,
    this.address,
    this.total,
  });
}
