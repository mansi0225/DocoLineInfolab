/// details : [{"pid":"6","did":"5","dfname":"twinkle","dlname":"shah","dgender":"female","dage":"22","dmobile":"32145698","dhospiadd":"dfsfdsf","dabout":"Dentist","dexp":"5","dcity":"ahmedabad","dstate":"gujarat","ddegree":"exp","dp":"images/IMG92AQQFRSlue.png"}]
/// error : false
/// message : "successfully data found."

class DoctorListApi {
  DoctorListApi({
      List<Details>? details, 
      bool? error, 
      String? message,}){
    _details = details;
    _error = error;
    _message = message;
}

  DoctorListApi.fromJson(dynamic json) {
    if (json['details'] != null) {
      _details = [];
      json['details'].forEach((v) {
        _details?.add(Details.fromJson(v));
      });
    }
    _error = json['error'];
    _message = json['message'];
  }
  List<Details>? _details;
  bool? _error;
  String? _message;
DoctorListApi copyWith({  List<Details>? details,
  bool? error,
  String? message,
}) => DoctorListApi(  details: details ?? _details,
  error: error ?? _error,
  message: message ?? _message,
);
  List<Details>? get details => _details;
  bool? get error => _error;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_details != null) {
      map['details'] = _details?.map((v) => v.toJson()).toList();
    }
    map['error'] = _error;
    map['message'] = _message;
    return map;
  }

}

/// pid : "6"
/// did : "5"
/// dfname : "twinkle"
/// dlname : "shah"
/// dgender : "female"
/// dage : "22"
/// dmobile : "32145698"
/// dhospiadd : "dfsfdsf"
/// dabout : "Dentist"
/// dexp : "5"
/// dcity : "ahmedabad"
/// dstate : "gujarat"
/// ddegree : "exp"
/// dp : "images/IMG92AQQFRSlue.png"

class Details {
  Details({
      String? pid, 
      String? did, 
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
    _did = did;
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

  Details.fromJson(dynamic json) {
    _pid = json['pid'];
    _did = json['did'];
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
  String? _did;
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
Details copyWith({  String? pid,
  String? did,
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
}) => Details(  pid: pid ?? _pid,
  did: did ?? _did,
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
  String? get did => _did;
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
    map['did'] = _did;
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