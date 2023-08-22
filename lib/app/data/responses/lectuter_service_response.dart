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
  String? province;
  String? amphure;
  String? district;
  String? lectuterPreName;
  String? lectuterFirstName;
  String? lectuterSurName;
  String? lectuterAgency;
  String? lectuterAffiliate;
  String? lectuterCourseNm;
  String? lectuterCourseYr;
  String? lectuterCourse;
  String? lectuterTelephone;
  String? lectuterLine;
  String? lectuterFacebook;
  String? lectuterExp;
  int? infoId;

  LectuterData(
      {this.id,
      this.name,
      this.province,
      this.amphure,
      this.district,
      this.lectuterPreName,
      this.lectuterFirstName,
      this.lectuterSurName,
      this.lectuterAgency,
      this.lectuterAffiliate,
      this.lectuterCourseNm,
      this.lectuterCourseYr,
      this.lectuterCourse,
      this.lectuterTelephone,
      this.lectuterLine,
      this.lectuterFacebook,
      this.lectuterExp,
      this.infoId});

  LectuterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    province = json['province'];
    amphure = json['amphure'];
    district = json['district'];
    lectuterPreName = json['lectuter_pre_name'];
    lectuterFirstName = json['lectuter_first_name'];
    lectuterSurName = json['lectuter_sur_name'];
    lectuterAgency = json['lectuter_agency'];
    lectuterAffiliate = json['lectuter_affiliate'];
    lectuterCourseNm = json['lectuter_course_nm'];
    lectuterCourseYr = json['lectuter_course_yr'];
    lectuterCourse = json['lectuter_course'];
    lectuterTelephone = json['lectuter_telephone'];
    lectuterLine = json['lectuter_line'];
    lectuterFacebook = json['lectuter_facebook'];
    lectuterExp = json['lectuter_exp'];
    infoId = json['info_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['province'] = province;
    data['amphure'] = amphure;
    data['district'] = district;
    data['lectuter_pre_name'] = lectuterPreName;
    data['lectuter_first_name'] = lectuterFirstName;
    data['lectuter_sur_name'] = lectuterSurName;
    data['lectuter_agency'] = lectuterAgency;
    data['lectuter_affiliate'] = lectuterAffiliate;
    data['lectuter_course_nm'] = lectuterCourseNm;
    data['lectuter_course_yr'] = lectuterCourseYr;
    data['lectuter_course'] = lectuterCourse;
    data['lectuter_telephone'] = lectuterTelephone;
    data['lectuter_line'] = lectuterLine;
    data['lectuter_facebook'] = lectuterFacebook;
    data['lectuter_exp'] = lectuterExp;
    data['info_id'] = infoId;
    return data;
  }
}
