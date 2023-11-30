class Laboratory {
  Laboratory({
      this.lid,
      this.lname,
      this.ladd,
      this.lmobile,
      this.lpic,});

  Laboratory.fromJsonMap(Map<String, dynamic> map) {
    lid = map['lid'];
    lname = map['lname'];
    ladd = map['ladd'];
    lmobile = map['lmobile'];
    lpic = map['lpic'];
  }
  String? lid;
  String? lname;
  String? ladd;
  String? lmobile;
  String? lpic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lid'] = lid;
    map['lname'] = lname;
    map['ladd'] = ladd;
    map['lmobile'] = lmobile;
    map['mpic'] = lpic;
    return map;
  }

}