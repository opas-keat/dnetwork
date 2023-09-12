class BudgetServiceResponse {
  String? code;
  String? message;
  List<BudgetData>? data;

  BudgetServiceResponse({this.code, this.message, this.data});

  BudgetServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

  BudgetServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BudgetData>[];
      json['data'].forEach((v) {
        data!.add(BudgetData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BudgetData {
  int? id;
  String? budgetDate;
  String? budgetType;
  int? budgetBegin;
  int? budgetUsed;
  int? budgetRemain;
  String? province;
  String? budgetYear;
  String? budgetName;

  BudgetData({
    this.id,
    this.budgetDate,
    this.budgetType,
    this.budgetBegin,
    this.budgetUsed,
    this.budgetRemain,
    this.province,
    this.budgetYear,
    this.budgetName,
  });

  BudgetData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    budgetDate = json['budget_date'];
    budgetType = json['budget_type'];
    budgetBegin = json['budget_begin'];
    budgetUsed = json['budget_used'];
    budgetRemain = json['budget_remain'];
    province = json['province'];
    budgetYear = json['budget_year'];
    budgetName = json['budget_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['budget_date'] = budgetDate;
    data['budget_type'] = budgetType;
    data['budget_begin'] = budgetBegin;
    data['budget_used'] = budgetUsed;
    data['budget_remain'] = budgetRemain;
    data['province'] = province;
    data['budget_year'] = budgetYear;
    data['budget_name'] = budgetName;
    return data;
  }
}
