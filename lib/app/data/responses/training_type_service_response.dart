class TrainingTypeServiceResponse {
  String? code;
  String? message;
  List<TrainingTypeData>? data;

  TrainingTypeServiceResponse({this.code, this.message, this.data});

  TrainingTypeServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

  TrainingTypeServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TrainingTypeData>[];
      json['data'].forEach((v) {
        data!.add(TrainingTypeData.fromJson(v));
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

class TrainingTypeData {
  int? id;
  String? name;
  int? totalData;

  TrainingTypeData({this.id, this.name, this.totalData});

  TrainingTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalData = json['total_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['total_data'] = totalData;
    return data;
  }
}
