class LectuterServiceRequest {
  List<Lectuters>? lectuters;

  LectuterServiceRequest({this.lectuters});

  LectuterServiceRequest.fromJson(Map<String, dynamic> json) {
    if (json['lectuters'] != null) {
      lectuters = <Lectuters>[];
      json['lectuters'].forEach((v) {
        lectuters!.add(Lectuters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (lectuters != null) {
      data['lectuters'] = lectuters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lectuters {
  String? lectuterPreName;
  String? lectuterFirstName;
  String? lectuterSurName;
  String? lectuterTelephone;
  String? lectuterLine;
  String? lectuterFacebook;
  String? lectuterAgency;
  String? lectuterAffiliate;
  String? lectuterExp;
  String? province;

  Lectuters(
      {this.lectuterPreName,
      this.lectuterFirstName,
      this.lectuterSurName,
      this.lectuterTelephone,
      this.lectuterLine,
      this.lectuterFacebook,
      this.lectuterAgency,
      this.lectuterAffiliate,
      this.lectuterExp,
      this.province});

  Lectuters.fromJson(Map<String, dynamic> json) {
    lectuterPreName = json['lectuter_pre_name'];
    lectuterFirstName = json['lectuter_first_name'];
    lectuterSurName = json['lectuter_sur_name'];
    lectuterTelephone = json['lectuter_telephone'];
    lectuterLine = json['lectuter_line'];
    lectuterFacebook = json['lectuter_facebook'];
    lectuterAgency = json['lectuter_agency'];
    lectuterAffiliate = json['lectuter_affiliate'];
    lectuterExp = json['lectuter_exp'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lectuter_pre_name'] = lectuterPreName;
    data['lectuter_first_name'] = lectuterFirstName;
    data['lectuter_sur_name'] = lectuterSurName;
    data['lectuter_telephone'] = lectuterTelephone;
    data['lectuter_line'] = lectuterLine;
    data['lectuter_facebook'] = lectuterFacebook;
    data['lectuter_agency'] = lectuterAgency;
    data['lectuter_affiliate'] = lectuterAffiliate;
    data['lectuter_exp'] = lectuterExp;
    data['province'] = province;
    return data;
  }
}
