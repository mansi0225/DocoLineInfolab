class DoctorProfileApi {
  DoctorProfileApi({
      bool? error, 
      String? message, 
      User? user,}){
    _error = error;
    _message = message;
    _user = user;
}

  DoctorProfileApi.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  bool? _error;
  String? _message;
  User? _user;
DoctorProfileApi copyWith({  bool? error,
  String? message,
  User? user,
}) => DoctorProfileApi(  error: error ?? _error,
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
      String? pid, 
      String? dfname, 
      String? dlname, 
      String? dgender, 
      String? dage, 
      String? dmobile, 
      String? dhospiadd, 
      String? dabout, 
      String? dexp, 
      String? dcity, 
      String? dstate, 
      String? ddegree, 
      String? dp,}){
    _pid = pid;
    _dfname = dfname;
    _dlname = dlname;
    _dgender = dgender;
    _dage = dage;
    _dmobile = dmobile;
    _dhospiadd = dhospiadd;
    _dabout = dabout;
    _dexp = dexp;
    _dcity = dcity;
    _dstate = dstate;
    _ddegree = ddegree;
    _dp = dp;
}

  User.fromJson(dynamic json) {
    _pid = json['pid'];
    _dfname = json['dfname'];
    _dlname = json['dlname'];
    _dgender = json['dgender'];
    _dage = json['dage'];
    _dmobile = json['dmobile'];
    _dhospiadd = json['dhospiadd'];
    _dabout = json['dabout'];
    _dexp = json['dexp'];
    _dcity = json['dcity'];
    _dstate = json['dstate'];
    _ddegree = json['ddegree'];
    _dp = json['dp'];
  }
  String? _pid;
  String? _dfname;
  String? _dlname;
  String? _dgender;
  String? _dage;
  String? _dmobile;
  String? _dhospiadd;
  String? _dabout;
  String? _dexp;
  String? _dcity;
  String? _dstate;
  String? _ddegree;
  String? _dp;
User copyWith({  String? pid,
  String? dfname,
  String? dlname,
  String? dgender,
  String? dage,
  String? dmobile,
  String? dhospiadd,
  String? dabout,
  String? dexp,
  String? dcity,
  String? dstate,
  String? ddegree,
  String? dp,
}) => User(  pid: pid ?? _pid,
  dfname: dfname ?? _dfname,
  dlname: dlname ?? _dlname,
  dgender: dgender ?? _dgender,
  dage: dage ?? _dage,
  dmobile: dmobile ?? _dmobile,
  dhospiadd: dhospiadd ?? _dhospiadd,
  dabout: dabout ?? _dabout,
  dexp: dexp ?? _dexp,
  dcity: dcity ?? _dcity,
  dstate: dstate ?? _dstate,
  ddegree: ddegree ?? _ddegree,
  dp: dp ?? _dp,
);
  String? get pid => _pid;
  String? get dfname => _dfname;
  String? get dlname => _dlname;
  String? get dgender => _dgender;
  String? get dage => _dage;
  String? get dmobile => _dmobile;
  String? get dhospiadd => _dhospiadd;
  String? get dabout => _dabout;
  String? get dexp => _dexp;
  String? get dcity => _dcity;
  String? get dstate => _dstate;
  String? get ddegree => _ddegree;
  String? get dp => _dp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pid'] = _pid;
    map['dfname'] = _dfname;
    map['dlname'] = _dlname;
    map['dgender'] = _dgender;
    map['dage'] = _dage;
    map['dmobile'] = _dmobile;
    map['dhospiadd'] = _dhospiadd;
    map['dabout'] = _dabout;
    map['dexp'] = _dexp;
    map['dcity'] = _dcity;
    map['dstate'] = _dstate;
    map['ddegree'] = _ddegree;
    map['dp'] = _dp;
    return map;
  }

}