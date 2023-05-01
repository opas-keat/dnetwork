List listBudgetStatisticsData = [
  BudgetStatisticsData(
    date: "25/05/2566",
    type: "ภารกิจการดำเนินโครงการของสำนักพัฒนาเครือข่ายการเลือกตั้ง 2566",    
    budgetBegin: 10000000,
    budgetUsed: 900000,
    budgetRemain: 100000,
    province: "กรุงเทพมหานคร",
  ),
  BudgetStatisticsData(
    date: "20/05/2566",
    type: "ภารกิจการดำเนินโครงการของสำนักพัฒนาเครือข่ายการเลือกตั้ง 2566",    
    budgetBegin: 10000000,
    budgetUsed: 200000,
    budgetRemain: 800000,
    province: "กรุงเทพมหานคร",
  ),
  BudgetStatisticsData(
    date: "25/04/2566",
    type: "ภารกิจการดำเนินโครงการของสำนักพัฒนาเครือข่ายการเลือกตั้ง 2566",    
    budgetBegin: 10000000,
    budgetUsed: 900000,
    budgetRemain: 100000,
    province: "กรุงเทพมหานคร",
  ),
  BudgetStatisticsData(
    date: "24/04/2566",
    type: "ภารกิจการดำเนินโครงการของสำนักพัฒนาเครือข่ายการเลือกตั้ง 2566",    
    budgetBegin: 10000000,
    budgetUsed: 900000,
    budgetRemain: 100000,
    province: "กรุงเทพมหานคร",
  ),
  BudgetStatisticsData(
    date: "25/03/2566",
    type: "ภารกิจการดำเนินโครงการของสำนักพัฒนาเครือข่ายการเลือกตั้ง 2566",    
    budgetBegin: 10000000,
    budgetUsed: 900000,
    budgetRemain: 100000,
    province: "กรุงเทพมหานคร",
  ),
  BudgetStatisticsData(
    date: "19/03/2566",
    type: "ภารกิจการดำเนินโครงการของสำนักพัฒนาเครือข่ายการเลือกตั้ง 2566",    
    budgetBegin: 10000000,
    budgetUsed: 900000,
    budgetRemain: 100000,
    province: "กรุงเทพมหานคร",
  ),
  BudgetStatisticsData(
    date: "01/01/2566",
    type: "ภารกิจการดำเนินโครงการของสำนักพัฒนาเครือข่ายการเลือกตั้ง 2566",    
    budgetBegin: 10000000,
    budgetUsed: 900000,
    budgetRemain: 100000,
    province: "กรุงเทพมหานคร",
  ),
];

class BudgetStatisticsData {
  String? date, type, province;
  int? budgetBegin, budgetUsed, budgetRemain;
  BudgetStatisticsData({
    this.date,
    this.type,
    this.province,
    this.budgetBegin,
    this.budgetUsed,
    this.budgetRemain,
  });
}
