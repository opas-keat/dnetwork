List listMemberStatisticsData = [
  MemberStatisticsData(
    name: "นายอลงกรณ์ โนนคู่เขตโขง",
    telephone: "096-998-8444",
    position: "ประธานกรรมการ",
    commissDate: "12/02/2566",
    commissLocation: "ศูนย์ส่งเสริมพัฒนาประชาธิปไตยและการเลือกตั้งแขวงลาดยาว",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงลาดยาว",
  ),
  MemberStatisticsData(
    name: "นางสาวกัญฑิมา แม้นเหลืองอ่อน",
    telephone: "095-957-3311",
    position: "รองประธานกรรมการ",
    commissDate: "12/02/2566",
    commissLocation:
        "ศูนย์ส่งเสริมพัฒนาประชาธิปไตยและการเลือกตั้งแขวงจันทรเกษม สาขา 6",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงจันทรเกษม",
  ),
  MemberStatisticsData(
    name: "นายณเดช คูกิมิยะ",
    telephone: "099-999-9999",
    position: "กรรมการ",
    commissDate: "12/02/2566",
    commissLocation: "ศูนย์ส่งเสริมพัฒนาประชาธิปไตยและการเลือกตั้งแขวงจอมพล",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงจอมพล",
  ),
  MemberStatisticsData(
    name: "นายทศพล เจริญกรุง",
    telephone: "095-588-9999",
    position: "กรรมการ/นายทะเบียน",
    commissDate: "12/02/2566",
    commissLocation: "ศูนย์ส่งเสริมพัฒนาประชาธิปไตยและการเลือกตั้งแขวงจตุจักร",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงจตุจักร",
  ),
  MemberStatisticsData(
    name: "นายโอภาส ทรงคุณค่า",
    telephone: "098-556-9875",
    position: "กรรมการ/เหรัญญิก",
    commissDate: "12/02/2566",
    commissLocation:
        "ศูนย์ส่งเสริมพัฒนาประชาธิปไตยและการเลือกตั้งแขวงเสนานิคม สาขา 4",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงเสนานิคม",
  ),
  MemberStatisticsData(
    name: "นางสาวกมลวรรณ โนนคู่เขตโขง",
    telephone: "088-888-4444",
    position: "กรรมการ/ประชาสัมพันธ์",
    commissDate: "12/02/2566",
    commissLocation:
        "ศูนย์ส่งเสริมพัฒนาประชาธิปไตยและการเลือกตั้งแขวงเสนานิคม สาขา 7",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงเสนานิคม",
  ),
  MemberStatisticsData(
    name: "นายสมพส แม้นเหลืองอ่อน",
    telephone: "081-235-9874",
    position: "กรรมการ/เลขานุการ",
    commissDate: "12/02/2566",
    commissLocation:
        "ศูนย์ส่งเสริมพัฒนาประชาธิปไตยและการเลือกตั้งแขวงเสนานิคม สาขา 8",
    address: "กรุงเทพมหานคร/เขตจตุจักร/แขวงเสนานิคม",
  ),
];

class MemberStatisticsData {
  String? name, telephone, position, commissDate, commissLocation, address;
  MemberStatisticsData({
    this.name,
    this.telephone,
    this.position,
    this.commissDate,
    this.commissLocation,
    this.address,
  });
}
