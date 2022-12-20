

class Sign_Up_Model {
  String? name;
  String? password;
  String? email;
  String? userRole;
  String? office;
  String? phoneNo;
  String? code;

  Sign_Up_Model(
      {this.name,
        this.password,
        this.email,
        this.userRole,
        this.office,
        this.phoneNo,
        this.code});

  Sign_Up_Model.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    password = json['password'];
    email = json['email'];
    userRole = json['user_role'];
    office = json['office'];
    phoneNo = json['phone_no'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['password'] = this.password;
    data['email'] = this.email;
    data['user_role'] = this.userRole;
    data['office'] = this.office;
    data['phone_no'] = this.phoneNo;
    data['code'] = this.code;
    return data;
  }
}