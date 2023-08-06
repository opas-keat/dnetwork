List<StationStatisticsData> listStationStatisticsDataModel = [
  StationStatisticsData(
    name: "ศูนย์ส่งเสริมพัฒนาประชาธิปไตยและการเลือกตั้งแขวงลาดยาว",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงลาดยาว",
    totalCommiss: 10,
    totalMember: 20,
  ),
  StationStatisticsData(
    name: "ศูนย์ส่งเสริมพัฒนาประชาธิปไตยและการเลือกตั้งแขวงจันทรเกษม สาขา 6",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงจันทรเกษม",
    totalCommiss: 19,
    totalMember: 20,
  ),
  StationStatisticsData(
    name: "ศูนย์ส่งเสริมพัฒนาประชาธิปไตยและการเลือกตั้งแขวงจอมพล",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงจอมพล",
    totalCommiss: 10,
    totalMember: 20,
  ),
  StationStatisticsData(
    name: "ศูนย์ส่งเสริมพัฒนาประชาธิปไตยและการเลือกตั้งแขวงจตุจักร",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงจตุจักร",
    totalCommiss: 12,
    totalMember: 20,
  ),
  StationStatisticsData(
    name: "ศูนย์ส่งเสริมพัฒนาประชาธิปไตยและการเลือกตั้งแขวงเสนานิคม สาขา 4",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงเสนานิคม",
    totalCommiss: 19,
    totalMember: 11,
  ),
  StationStatisticsData(
    name: "ศูนย์ส่งเสริมพัฒนาประชาธิปไตยและการเลือกตั้งแขวงเสนานิคม สาขา 7",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงเสนานิคม",
    totalCommiss: 15,
    totalMember: 22,
  ),
  StationStatisticsData(
    name: "ศูนย์ส่งเสริมพัฒนาประชาธิปไตยและการเลือกตั้งแขวงเสนานิคม สาขา 8",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงเสนานิคม",
    totalCommiss: 18,
    totalMember: 28,
  ),
];

class StationStatisticsData {
  String? name, address;
  int? totalCommiss, totalMember;
  StationStatisticsData({
    this.name,
    this.address,
    this.totalCommiss,
    this.totalMember,
  });
}
