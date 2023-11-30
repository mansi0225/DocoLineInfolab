/// status : [{"slotid":"3","docid":"5","date":"2023-03-17","time":"12:00 - 01:00","slotstatus":"0"}]
/// error : false
/// message : "successfully data found."

class FetchSlotApi {
  FetchSlotApi({
      List<Status>? status, 
      bool? error, 
      String? message,}){
    _status = status;
    _error = error;
    _message = message;
}

  FetchSlotApi.fromJson(dynamic json) {
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
FetchSlotApi copyWith({  List<Status>? status,
  bool? error,
  String? message,
}) => FetchSlotApi(  status: status ?? _status,
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

/// slotid : "3"
/// docid : "5"
/// date : "2023-03-17"
/// time : "12:00 - 01:00"
/// slotstatus : "0"

class Status {
  Status({
      String? slotid, 
      String? docid, 
      String? date, 
      String? time, 
      String? slotstatus,}){
    _slotid = slotid;
    _docid = docid;
    _date = date;
    _time = time;
    _slotstatus = slotstatus;
}

  Status.fromJson(dynamic json) {
    _slotid = json['slotid'];
    _docid = json['docid'];
    _date = json['date'];
    _time = json['time'];
    _slotstatus = json['slotstatus'];
  }
  String? _slotid;
  String? _docid;
  String? _date;
  String? _time;
  String? _slotstatus;
Status copyWith({  String? slotid,
  String? docid,
  String? date,
  String? time,
  String? slotstatus,
}) => Status(  slotid: slotid ?? _slotid,
  docid: docid ?? _docid,
  date: date ?? _date,
  time: time ?? _time,
  slotstatus: slotstatus ?? _slotstatus,
);
  String? get slotid => _slotid;
  String? get docid => _docid;
  String? get date => _date;
  String? get time => _time;
  String? get slotstatus => _slotstatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slotid'] = _slotid;
    map['docid'] = _docid;
    map['date'] = _date;
    map['time'] = _time;
    map['slotstatus'] = _slotstatus;
    return map;
  }

}