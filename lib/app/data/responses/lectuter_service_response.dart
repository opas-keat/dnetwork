class LectuterServiceResponse {
  String? code;
  String? message;
  List<LectuterData>? data;

  LectuterServiceResponse({this.code, this.message, this.data});

  LectuterServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

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
  String? lectuterFirstName;
  String? lectuterSurName;

  LectuterData(
      {this.id,
      this.name,
      this.telephone,
      this.agency,
      this.affiliate,
      this.province,
      this.lectuterFirstName,
      this.lectuterSurName});

  LectuterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    telephone = json['telephone'];
    agency = json['agency'];
    affiliate = json['affiliate'];
    province = json['province'];
    lectuterFirstName = json['lectuter_first_name'];
    lectuterSurName = json['lectuter_sur_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['telephone'] = telephone;
    data['agency'] = agency;
    data['affiliate'] = affiliate;
    data['province'] = province;
    data['lectuter_first_name'] = lectuterFirstName;
    data['lectuter_sur_name'] = lectuterSurName;
    return data;
  }
}
