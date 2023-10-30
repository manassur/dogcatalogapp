class GenericResponse {
  String? message;
  bool? error;
  String? code;
  String? id;

  // this is a class function
  GenericResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    code = json['code']==null?'': json['code'].toString();
    id = json['id']==null?'': json['id'].toString();

  }
}
