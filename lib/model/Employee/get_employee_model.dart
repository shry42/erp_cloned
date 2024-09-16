class GetEmployeeListModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? emailId;
  final String? empId;
  final String? department;
  final String? mobileNo;
  final String? doj;
  final String? reportingManager;
  final String? location;

  GetEmployeeListModel({
    this.id,
    this.firstName,
    this.lastName,
    this.emailId,
    this.empId,
    this.department,
    this.mobileNo,
    this.doj,
    this.reportingManager,
    this.location,
  });

  factory GetEmployeeListModel.fromJson(Map<String, dynamic> json) {
    return GetEmployeeListModel(
      id: json['id'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      emailId: json['emailId'] as String?,
      empId: json['empId'] as String?,
      department: json['department'] as String?,
      mobileNo: json['mobileNo'] as String?,
      doj: json['doj'] as String?,
      reportingManager: json['reportingManager'] as String?,
      location: json['location'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'emailId': emailId,
      'empId': empId,
      'department': department,
      'mobileNo': mobileNo,
      'doj': doj,
      'reportingManager': reportingManager,
      'location': location,
    };
  }
}
