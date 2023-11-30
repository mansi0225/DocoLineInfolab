import 'Laboratory.dart';

class LaboratoryListApi {
  LaboratoryListApi({
      required this.laboratory,
    required this.error,
    required this.message,});

  LaboratoryListApi.fromJsonMap(Map<String, dynamic> map) {
    if (map['laboratory'] != null) {
      laboratory = [];
      map['laboratory'].forEach((v) {
        laboratory!.add(Laboratory.fromJsonMap(v));
      });
    }
    error = map['error'];
    message = map['message'];
  }
  List<Laboratory>? laboratory;
  bool? error;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (laboratory != null) {
      map['laboratory'] = laboratory!.map((v) => v.toJson()).toList();
    }
    map['error'] = error;
    map['message'] = message;
    return map;
  }

}