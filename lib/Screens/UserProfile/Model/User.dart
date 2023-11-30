class User {
  User({
      this.pid, 
      this.ufname, 
      this.ulname, 
      this.ugender, 
      this.uage, 
      this.ubloodg, 
      this.umobile, 
      this.uadd, 
      this.ucity, 
      this.ustate,});

  User.fromJsonMap(Map<String, dynamic> map) {
    pid = map['pid'] ?? "";
    ufname = map['ufname'] ?? "";
    ulname = map['ulname'] ?? "" ;
    ugender = map['ugender'] ?? "";
    uage = map['uage'] ?? "";
    ubloodg = map['ubloodg'] ?? "";
    umobile = map['umobile'] ?? "";
    uadd = map['uadd'] ?? "";
    ucity = map['ucity'] ?? "";
    ustate = map['ustate'] ?? "";
  }
  String? pid;
  String? ufname;
  String? ulname;
  String? ugender;
  String? uage;
  String? ubloodg;
  String? umobile;
  String? uadd;
  String? ucity;
  String? ustate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pid'] = pid;
    map['ufname'] = ufname;
    map['ulname'] = ulname;
    map['ugender'] = ugender;
    map['uage'] = uage;
    map['ubloodg'] = ubloodg;
    map['umobile'] = umobile;
    map['uadd'] = uadd;
    map['ucity'] = ucity;
    map['ustate'] = ustate;
    return map;
  }

}