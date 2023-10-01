class FileAttachServiceResponse {
  String? code;
  String? message;
  List<FileAttachData>? data;

  FileAttachServiceResponse({this.code, this.message, this.data});

  FileAttachServiceResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FileAttachData>[];
      json['data'].forEach((v) {
        data!.add(FileAttachData.fromJson(v));
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

class FileAttachData {
  int? id;
  String? fileName;
  String? fileType;
  int? fileSize;
  String? module;
  String? linkType;
  int? linkId;
  String? fileUrl;

  FileAttachData(
      {this.id,
      this.fileName,
      this.fileType,
      this.fileSize,
      this.module,
      this.linkType,
      this.linkId,
      this.fileUrl});

  FileAttachData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['file_name'];
    fileType = json['file_type'];
    fileSize = json['file_size'];
    module = json['module'];
    linkType = json['link_type'];
    linkId = json['link_id'];
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['file_name'] = fileName;
    data['file_type'] = fileType;
    data['file_size'] = fileSize;
    data['module'] = module;
    data['link_type'] = linkType;
    data['link_id'] = linkId;
    data['file_url'] = fileUrl;
    return data;
  }
}
