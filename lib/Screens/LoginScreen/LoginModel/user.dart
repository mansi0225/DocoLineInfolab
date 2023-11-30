
class User {

  final String uid;
  final String uname;
  final String uemail;

	User.fromJsonMap(Map<String, dynamic> map):
		uid = map["uid"] ?? "",
		uname = map["uname"] ?? "",
		uemail = map["uemail"] ?? "";

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = uid;
		data['uname'] = uname;
		data['uemail'] = uemail;
		return data;
	}
}
