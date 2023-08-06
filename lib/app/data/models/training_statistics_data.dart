List<TrainingStatisticsData> listTrainingStatisticsData = [
  TrainingStatisticsData(
    name:
        "โครงการรับฟังความคิดเห็นและข้อเสนอแนะ ร่างพระราชบัญญัติการจัดซื้อจัดจ้างและการบริหารพัสดุภาครัฐ",
    date: "25/05/2558 ถึง 27/05/2558",
    type: "การอบรม ศศ.ปชต.",
    province: "กรุงเทพมหานคร",
    total: 50,
  ),
  TrainingStatisticsData(
    name: "เสวนาวิชาการเรื่อง ร่วมคิดนโยบายการปฏิรูปการศึกษาไทยด้วยงานวิจัย",
    date: "25/05/2558 ถึง 28/05/2558",
    type: "การอบรมของภาครัฐ",
    province: "กรุงเทพมหานคร",
    total: 20,
  ),
  TrainingStatisticsData(
    name: "สัมมนา มังกรผงาดมุ่งลงใต้ : ไทยควรรุกหรือรับอย่างไร",
    date: "25/05/2559 ถึง 27/05/2559",
    type: "การอบรมของสำนักงาน กกต.",
    province: "กรุงเทพมหานคร",
    total: 20,
  ),
  TrainingStatisticsData(
    name: "อบรมหลักสูตร การบริหารเบื้องต้น",
    date: "25/05/2560 ถึง 27/05/2560",
    type: "การอบรมของภาครัฐ",
    province: "กรุงเทพมหานคร",
    total: 30,
  ),
  TrainingStatisticsData(
    name:
        "ประชุมเวทีเตรียมความพร้อมกลุ่มภาคีเครือข่ายสำหรับการประชุมสมัชชาสุขภาพขององค์กร",
    date: "25/05/2562 ถึง 27/05/2562",
    type: "การอบรมของภาครัฐ",
    province: "กรุงเทพมหานคร",
    total: 10,
  ),
  TrainingStatisticsData(
    name: "อบรมหลักสูตร เทคนิคการวิจัยทางสังคมศาสตร์แบบผสม (MIXED METHOD)",
    date: "25/05/2565 ถึง 27/05/2565",
    type: "การอบรมของภาครัฐ",
    province: "กรุงเทพมหานคร",
    total: 11,
  ),
  TrainingStatisticsData(
    name:
        "อบรมหลักสูตร ความมั่นคงของระบบภาคีเครือข่ายไร้สายและเว็บแอปพลิเคชั่น รุ่นที่ 1",
    date: "25/05/2566 ถึง 27/05/2566",
    type: "การอบรมของภาครัฐ",
    province: "กรุงเทพมหานคร",
    total: 12,
  ),
];

class TrainingStatisticsData {
  String? name, date, type, province;
  int? total;
  TrainingStatisticsData({
    this.name,
    this.date,
    this.type,
    this.province,
    this.total,
  });
}
