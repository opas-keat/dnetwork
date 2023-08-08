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
  String? budgetDate;
  String? budgetType;
  int? budgetBegin;
  int? budgetUsed;
  int? budgetRemain;
  String? province;

  Budgets(
      {this.budgetDate,
      this.budgetType,
      this.budgetBegin,
      this.budgetUsed,
      this.budgetRemain,
      this.province});

  Budgets.fromJson(Map<String, dynamic> json) {
    budgetDate = json['budget_date'];
    budgetType = json['budget_type'];
    budgetBegin = json['budget_begin'];
    budgetUsed = json['budget_used'];
    budgetRemain = json['budget_remain'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['budget_date'] = budgetDate;
    data['budget_type'] = budgetType;
    data['budget_begin'] = budgetBegin;
    data['budget_used'] = budgetUsed;
    data['budget_remain'] = budgetRemain;
    data['province'] = province;
    return data;
  }
}
