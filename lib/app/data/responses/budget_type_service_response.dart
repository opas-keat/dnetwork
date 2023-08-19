class BudgetTypeServiceResponse {
  String? code;
  String? message;
  List<BudgetTypeData>? data;

  BudgetTypeServiceResponse({this.code, this.message, this.data});

  BudgetTypeServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

  BudgetTypeServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BudgetTypeData>[];
      json['data'].forEach((v) {
        data!.add(BudgetTypeData.fromJson(v));
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

class BudgetTypeData {
  int? id;
  String? name;

  BudgetTypeData({this.id, this.name});

  BudgetTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
