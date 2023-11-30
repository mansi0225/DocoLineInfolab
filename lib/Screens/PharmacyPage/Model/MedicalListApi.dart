/// medical : [{"mid":"1","mname":"krishna","madd":"surat","mmobile":"343435435","mpic":"https://img.freepik.com/free-photo/flat-lay-health-still-life-arrangement-with-copy-space_23-2148854064.jpg"}]
/// error : false
/// message : "successfully data found."

class MedicalListApi {
  MedicalListApi({
      List<Medical>? medical, 
      bool? error, 
      String? message,}){
    _medical = medical;
    _error = error;
    _message = message;
}

  MedicalListApi.fromJsonMap(Map<String, dynamic> map) {
    if (map['medical'] != null) {
      _medical = [];
      map['medical'].forEach((v) {
        _medical?.add(Medical.fromJsonMap(v));
      });
    }
    _error = map['error'];
    _message = map['message'];
  }
  List<Medical>? _medical;
  bool? _error;
  String? _message;
MedicalListApi copyWith({  List<Medical>? medical,
  bool? error,
  String? message,
}) => MedicalListApi(  medical: medical ?? _medical,
  error: error ?? _error,
  message: message ?? _message,
);
  List<Medical>? get medical => _medical;
  bool? get error => _error;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_medical != null) {
      map['medical'] = _medical?.map((v) => v.toJson()).toList();
    }
    map['error'] = _error;
    map['message'] = _message;
    return map;
  }

}

/// mid : "1"
/// mname : "krishna"
/// madd : "surat"
/// mmobile : "343435435"
/// mpic : "https://img.freepik.com/free-photo/flat-lay-health-still-life-arrangement-with-copy-space_23-2148854064.jpg"

class Medical {
  Medical({
      String? mid, 
      String? mname, 
      String? madd, 
      String? mmobile, 
      String? mpic,}){
    _mid = mid;
    _mname = mname;
    _madd = madd;
    _mmobile = mmobile;
    _mpic = mpic;
}

  Medical.fromJsonMap(Map<String, dynamic> map) {
    _mid = map['mid'];
    _mname = map['mname'];
    _madd = map['madd'];
    _mmobile = map['mmobile'];
    _mpic = map['mpic'];
  }
  String? _mid;
  String? _mname;
  String? _madd;
  String? _mmobile;
  String? _mpic;
Medical copyWith({  String? mid,
  String? mname,
  String? madd,
  String? mmobile,
  String? mpic,
}) => Medical(  mid: mid ?? _mid,
  mname: mname ?? _mname,
  madd: madd ?? _madd,
  mmobile: mmobile ?? _mmobile,
  mpic: mpic ?? _mpic,
);
  String? get mid => _mid;
  String? get mname => _mname;
  String? get madd => _madd;
  String? get mmobile => _mmobile;
  String? get mpic => _mpic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mid'] = _mid;
    map['mname'] = _mname;
    map['madd'] = _madd;
    map['mmobile'] = _mmobile;
    map['mpic'] = _mpic;
    return map;
  }

}