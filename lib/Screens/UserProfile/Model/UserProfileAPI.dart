import 'User.dart';

class UserProfileApi {
  UserProfileApi({
      this.error, 
      this.message, 
      this.user,});

  UserProfileApi.fromJsonMap(Map<String, dynamic> map) {
    error = map['error'];
    message = map['message'];
    user = map['user'] != null ? User.fromJsonMap(map['user']) : null;
  }
  bool? error;
  String? message;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['message'] = message;
    if (user != null) {
      map['user'] = user!.toJson();
    }
    return map;
  }

}