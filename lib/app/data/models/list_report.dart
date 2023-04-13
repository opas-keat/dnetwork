List<BugReport> listBugReport = [
  BugReport(
    id: 1,
    createdDate: "15/04/2566",
    module: "ศส.ปชต.",
    detail: "ไม่สามารถเพิ่มข้อมูล ศส.ปชต. ได้",
    userName: "user01",
    status: "แก้ไขแล้ว",
  ),
  BugReport(
    id: 2,
    createdDate: "15/04/2566",
    module: "กรรมการ",
    detail: "ไม่สามารถเพิ่มข้อมูล กรรมการ ได้",
    userName: "user01",
    status: "แก้ไขแล้ว",
  ),
  BugReport(
    id: 3,
    createdDate: "15/04/2566",
    module: "วิทยากรประชาธิปไตย",
    detail: "ไม่สามารถเพิ่มข้อมูล วิทยากรประชาธิปไตย ได้",
    userName: "user01",
    status: "แก้ไขแล้ว",
  ),
  BugReport(
    id: 4,
    createdDate: "15/04/2566",
    module: "หมู่บ้านไม่ขายเสียง",
    detail: "ไม่สามารถเพิ่มข้อมูล หมู่บ้านไม่ขายเสียง ได้",
    userName: "user01",
    status: "แก้ไขแล้ว",
  ),
  BugReport(
    id: 5,
    createdDate: "15/04/2566",
    module: "ศส.ปชต.",
    detail: "ไม่สามารถเพิ่มรูปภาพ ศส.ปชต. ได้",
    userName: "user01",
    status: "ยังไม่แก้ไข",
  ),
];

class BugReport {
  BugReport({
    this.id,
    this.createdDate,
    this.module,
    this.detail,
    this.userName,
    this.status,
  });
  int? id;
  String? createdDate;
  String? module;
  String? detail;
  String? userName;
  String? status;
}
