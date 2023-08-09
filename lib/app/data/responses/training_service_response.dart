class TrainingServiceResponse {
  String? code;
  String? message;
  List<TrainingData>? data;

  TrainingServiceResponse({this.code, this.message, this.data});

  TrainingServiceResponse.withError({
    code,
    String? msg,
  }) : message = msg;

  TrainingServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TrainingData>[];
      json['data'].forEach((v) {
        data!.add(TrainingData.fromJson(v));
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

class TrainingData {
  int? id;
  String? trainingName;
  String? trainingDateForm;
  String? trainingDateTo;
  String? trainingType;
  String? province;
  int? trainingTotal;

  TrainingData(
      {this.id,
      this.trainingName,
      this.trainingDateForm,
      this.trainingDateTo,
      this.trainingType,
      this.province,
      this.trainingTotal});

  TrainingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trainingName = json['training_name'];
    trainingDateForm = json['training_date_form'];
    trainingDateTo = json['training_date_to'];
    trainingType = json['training_type'];
    province = json['province'];
    trainingTotal = json['training_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['training_name'] = trainingName;
    data['training_date_form'] = trainingDateForm;
    data['training_date_to'] = trainingDateTo;
    data['training_type'] = trainingType;
    data['province'] = province;
    data['training_total'] = trainingTotal;
    return data;
  }
}
