class BudgetServiceRequest {
  List<Budgets>? budgets;

  BudgetServiceRequest({this.budgets});

  BudgetServiceRequest.fromJson(Map<String, dynamic> json) {
    if (json['budgets'] != null) {
      budgets = <Budgets>[];
      json['budgets'].forEach((v) {
        budgets!.add(Budgets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (budgets != null) {
      data['budgets'] = budgets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Budgets {
  int? id;
  String? budgetDate;
  String? budgetType;
  int? budgetBegin;
  int? budgetUsed;
  int? budgetRemain;
  String? province;
  String? budgetYear;
  String? budgetName;
  Budgets({
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

  Budgets.fromJson(Map<String, dynamic> json) {
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
