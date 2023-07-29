class ProvinceServiceResponse {
  String? code;
  String? message;
  List<ProvinceData>? data;

  ProvinceServiceResponse({this.code, this.message, this.data});

  ProvinceServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    message = json["message"];
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => ProvinceData.fromJson(e)).toList();
  }

  static List<ProvinceServiceResponse> fromList(
      List<Map<String, dynamic>> list) {
    return list.map((map) => ProvinceServiceResponse.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["code"] = code;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }

  ProvinceServiceResponse copyWith({
    String? code,
    String? message,
    List<ProvinceData>? data,
  }) =>
      ProvinceServiceResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data,
      );
}

class ProvinceData {
  String? id;
  String? pCode;
  String? pName;

  ProvinceData({this.id, this.pCode, this.pName});

  ProvinceData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    pCode = json["p_code"];
    pName = json["p_name"];
  }

  static List<ProvinceData> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ProvinceData.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["p_code"] = pCode;
    _data["p_name"] = pName;
    return _data;
  }

  ProvinceData copyWith({
    String? id,
    String? pCode,
    String? pName,
  }) =>
      ProvinceData(
        id: id ?? this.id,
        pCode: pCode ?? this.pCode,
        pName: pName ?? this.pName,
      );
}
