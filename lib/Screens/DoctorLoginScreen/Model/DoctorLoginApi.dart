class DoctorLoginApi {
  DoctorLoginApi({
      bool? error, 
      String? message, 
      User? user,}){
    _error = error;
    _message = message;
    _user = user;
}

  DoctorLoginApi.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  bool? _error;
  String? _message;
  User? _user;
DoctorLoginApi copyWith({  bool? error,
  String? message,
  User? user,
}) => DoctorLoginApi(  error: error ?? _error,
  message: message ?? _message,
  user: user ?? _user,
);
  bool? get error => _error;
  String? get message => _message;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

class User {
  User({
      String? did, 
      String? dname, 
      String? demail,}){
    _did = did;
    _dname = dname;
    _demail = demail;
}

  User.fromJson(dynamic json) {
    _did = json['did'];
    _dname = json['dname'];
    _demail = json['demail'];
  }
  String? _did;
  String? _dname;
  String? _demail;
User copyWith({  String? did,
  String? dname,
  String? demail,
}) => User(  did: did ?? _did,
  dname: dname ?? _dname,
  demail: demail ?? _demail,
);
  String? get did => _did;
  String? get dname => _dname;
  String? get demail => _demail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['did'] = _did;
    map['dname'] = _dname;
    map['demail'] = _demail;
    return map;
  }

}