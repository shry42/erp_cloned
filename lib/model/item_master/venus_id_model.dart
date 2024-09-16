class VenuIdModel {
  final bool? status;
  final String? data;

  VenuIdModel({
    this.status,
    this.data,
  });

  factory VenuIdModel.fromJson(Map<String, dynamic> json) {
    return VenuIdModel(
      status: json['status'] as bool?,
      data: json['data'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data,
    };
  }
}
