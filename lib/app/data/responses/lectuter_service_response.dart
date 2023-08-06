class LectuterServiceResponse {
  String? code;
  String? message;
  List<LectuterData>? data;

  LectuterServiceResponse({this.code, this.message, this.data});

  LectuterServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LectuterData>[];
      json['data'].forEach((v) {
        data!.add(LectuterData.fromJson(v));
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

class LectuterData {
  int? id;
  String? name;
  String? telephone;
  String? agency;
  String? affiliate;
  String? province;

  LectuterData(
      {this.id,
      this.name,
      this.telephone,
      this.agency,
      this.affiliate,
      this.province});

  LectuterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    telephone = json['telephone'];
    agency = json['agency'];
    affiliate = json['affiliate'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['telephone'] = telephone;
    data['agency'] = agency;
    data['affiliate'] = affiliate;
    data['province'] = province;
    return data;
  }
}
