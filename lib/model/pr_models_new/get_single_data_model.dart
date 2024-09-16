class SingleDataModel {
  bool? status;
  int? data;

  SingleDataModel({this.status, this.data});

  factory SingleDataModel.fromJson(Map<String, dynamic> json) {
    return SingleDataModel(
      status: json['status'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data,
    };
  }
}
