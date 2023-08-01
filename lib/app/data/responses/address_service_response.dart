class ProvinceServiceResponse {
  String? code;
  String? message;
  List<ProvinceData>? data;

  ProvinceServiceResponse({this.code, this.message, this.data});

  ProvinceServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProvinceData>[];
      json['data'].forEach((v) {
        data!.add(ProvinceData.fromJson(v));
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

class ProvinceData {
  String? id;
  String? pCode;
  String? pName;

  ProvinceData({this.id, this.pCode, this.pName});

  ProvinceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pCode = json['p_code'];
    pName = json['p_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['p_code'] = pCode;
    data['p_name'] = pName;
    return data;
  }
}

class AmphureServiceResponse {
  String? code;
  String? message;
  List<AmphureData>? data;

  AmphureServiceResponse({this.code, this.message, this.data});

  AmphureServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AmphureData>[];
      json['data'].forEach((v) {
        data!.add(AmphureData.fromJson(v));
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

class AmphureData {
  String? id;
  String? aCode;
  String? aName;
  String? pCode;
  String? pName;

  AmphureData({this.id, this.aCode, this.aName, this.pCode, this.pName});

  AmphureData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aCode = json['a_code'];
    aName = json['a_name'];
    pCode = json['p_code'];
    pName = json['p_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['a_code'] = aCode;
    data['a_name'] = aName;
    data['p_code'] = pCode;
    data['p_name'] = pName;
    return data;
  }
}

class TambolServiceResponse {
  String? code;
  String? message;
  List<TambolData>? data;

  TambolServiceResponse({this.code, this.message, this.data});

  TambolServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TambolData>[];
      json['data'].forEach((v) {
        data!.add(TambolData.fromJson(v));
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

class TambolData {
  String? id;
  String? tCode;
  String? tName;
  String? zipCode;
  String? aCode;
  String? aName;
  String? pCode;
  String? pName;

  TambolData(
      {this.id,
      this.tCode,
      this.tName,
      this.zipCode,
      this.aCode,
      this.aName,
      this.pCode,
      this.pName});

  TambolData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tCode = json['t_code'];
    tName = json['t_name'];
    zipCode = json['zip_code'];
    aCode = json['a_code'];
    aName = json['a_name'];
    pCode = json['p_code'];
    pName = json['p_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['t_code'] = tCode;
    data['t_name'] = tName;
    data['zip_code'] = zipCode;
    data['a_code'] = aCode;
    data['a_name'] = aName;
    data['p_code'] = pCode;
    data['p_name'] = pName;
    return data;
  }
}
