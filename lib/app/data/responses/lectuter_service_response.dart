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
  String? lectuterPreName;
  String? lectuterLine;
  String? lectuterFacebook;
  String? lectuterExp;

  LectuterData(
      {this.id,
      this.name,
      this.telephone,
      this.agency,
      this.affiliate,
      this.province,
      this.lectuterFirstName,
      this.lectuterSurName,
      this.lectuterPreName,
      this.lectuterLine,
      this.lectuterFacebook,
      this.lectuterExp});

  LectuterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    telephone = json['telephone'];
    agency = json['agency'];
    affiliate = json['affiliate'];
    province = json['province'];
    lectuterFirstName = json['lectuter_first_name'];
    lectuterSurName = json['lectuter_sur_name'];
    lectuterPreName = json['lectuter_pre_name'];
    lectuterLine = json['lectuter_line'];
    lectuterFacebook = json['lectuter_facebook'];
    lectuterExp = json['lectuter_exp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['telephone'] = this.telephone;
    data['agency'] = this.agency;
    data['affiliate'] = this.affiliate;
    data['province'] = this.province;
    data['lectuter_first_name'] = this.lectuterFirstName;
    data['lectuter_sur_name'] = this.lectuterSurName;
    data['lectuter_pre_name'] = this.lectuterPreName;
    data['lectuter_line'] = this.lectuterLine;
    data['lectuter_facebook'] = this.lectuterFacebook;
    data['lectuter_exp'] = this.lectuterExp;
    return data;
  }
}
