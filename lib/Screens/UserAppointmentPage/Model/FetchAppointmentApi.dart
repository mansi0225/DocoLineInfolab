/// status : [{"appoid":"4","dname":"twinkle","uid":"4","slot":"11:00 - 12:00","astatus":"1","report":"https://docoappo27.000webhostapp.com/doctor/reports/IMGTJAOI4KODAM-ADMIN-USECASE.png","prescri":"abc"},{"appoid":"5","dname":"twinkle","uid":"4","slot":"11:00 - 12:00","astatus":"0","report":"https://docoappo27.000webhostapp.com/doctor/reports/none","prescri":"none"},{"appoid":"8","dname":"twinkle","uid":"4","slot":"11:00 - 12:00","astatus":"0","report":"https://docoappo27.000webhostapp.com/doctor/reports/none","prescri":"none"}]
/// error : false
/// message : "successfully data found."

class FetchAppointmentApi {
  FetchAppointmentApi({
      List<Status>? status, 
      bool? error, 
      String? message,}){
    _status = status;
    _error = error;
    _message = message;
}

  FetchAppointmentApi.fromJson(dynamic json) {
    if (json['status'] != null) {
      _status = [];
      json['status'].forEach((v) {
        _status?.add(Status.fromJson(v));
      });
    }
    _error = json['error'];
    _message = json['message'];
  }
  List<Status>? _status;
  bool? _error;
  String? _message;
FetchAppointmentApi copyWith({  List<Status>? status,
  bool? error,
  String? message,
}) => FetchAppointmentApi(  status: status ?? _status,
  error: error ?? _error,
  message: message ?? _message,
);
  List<Status>? get status => _status;
  bool? get error => _error;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_status != null) {
      map['status'] = _status?.map((v) => v.toJson()).toList();
    }
    map['error'] = _error;
    map['message'] = _message;
    return map;
  }

}

/// appoid : "4"
/// dname : "twinkle"
/// uid : "4"
/// slot : "11:00 - 12:00"
/// astatus : "1"
/// report : "https://docoappo27.000webhostapp.com/doctor/reports/IMGTJAOI4KODAM-ADMIN-USECASE.png"
/// prescri : "abc"

class Status {
  Status({
      String? appoid, 
      String? dname, 
      String? uid, 
      String? slot, 
      String? astatus, 
      String? report, 
      String? prescri, String? date,}){
    _appoid = appoid;
    _dname = dname;
    _uid = uid;
    _slot = slot;
    _date = date;
    _astatus = astatus;
    _report = report;
    _prescri = prescri;
}

  Status.fromJson(dynamic json) {
    _appoid = json['appoid'];
    _dname = json['dname'];
    _uid = json['uid'];
    _slot = json['slot'];
    _date = json['date'];
    _astatus = json['astatus'];
    _report = json['report'];
    _prescri = json['prescri'];
  }
  String? _appoid;
  String? _dname;
  String? _uid;
  String? _slot;
  String? _date;
  String? _astatus;
  String? _report;
  String? _prescri;
Status copyWith({  String? appoid,
  String? dname,
  String? uid,
  String? slot,
  String? date,
  String? astatus,
  String? report,
  String? prescri,
}) => Status(  appoid: appoid ?? _appoid,
  dname: dname ?? _dname,
  uid: uid ?? _uid,
  slot: slot ?? _slot,
  date: date ?? _date,
  astatus: astatus ?? _astatus,
  report: report ?? _report,
  prescri: prescri ?? _prescri,
);
  String? get appoid => _appoid;
  String? get dname => _dname;
  String? get uid => _uid;
  String? get slot => _slot;
  String? get date => _date;
  String? get astatus => _astatus;
  String? get report => _report;
  String? get prescri => _prescri;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appoid'] = _appoid;
    map['dname'] = _dname;
    map['uid'] = _uid;
    map['slot'] = _slot;
    map['date'] = _date;
    map['astatus'] = _astatus;
    map['report'] = _report;
    map['prescri'] = _prescri;
    return map;
  }

}