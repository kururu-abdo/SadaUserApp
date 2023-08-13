class LoginModel {
  String? email;
  String? password;
  String?  method;
  String? user_id;
  LoginModel({this.email, this.password});

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['method']= this.method;
    data['user_id'] = this.user_id;
    return data;
  }
}
