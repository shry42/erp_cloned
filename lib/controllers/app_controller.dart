class AppController {
  static String? _Username;

  static String? _FullName;

  static String? _MobileNumber;

  static String? _EmailID;

  static String? _Department;

  static String? _UserRole;

  static String? _isActive;

  static String? _accessToken;

  static String? _message;

//For Vendor id

  static String _vendorId = "";

  static get id => _vendorId;
  static setId(value) {
    _vendorId = id;
  }

//setter Getter methods
  static get Username => _Username;
  static setUsername(value) {
    _Username = value;
  }

  static get FullName => _FullName;
  static setFullName(value) {
    _FullName = value;
  }

  static get MobileNumber => _MobileNumber;
  static setMobileNumber(value) {
    _MobileNumber = value;
  }

  static get EmailID => _EmailID;
  static setEmailID(value) {
    _EmailID = value;
  }

  static get Department => _Department;
  static setDepartment(value) {
    _Department = value;
  }

  static get UserRole => _UserRole;
  static setUserRole(value) {
    _UserRole = value;
  }

  static get isActive => _isActive;
  static set_isActive(value) {
    _isActive = value;
  }

  static get accessToken => _accessToken;
  static setaccessToken(value) {
    _accessToken = value;
  }

  static get message => _message;
  static setmessage(value) {
    _message = value;
  }
}
