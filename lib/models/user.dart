class User {
  String? id;
  String? email;
  String? name;
  String? phone;
  String? password;
  String? totalcredit;
  String? otp;
  String? datereg;

  

  User(
      {this.id,
      this.email,
      this.name,
      this.phone,
      this.password,
      this.totalcredit,
      this.otp,
      this.datereg});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
    totalcredit = json['totalcredit'];
    otp = json['otp'];
    datereg = json['datereg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    data['password'] = password;
    data['totalcredit'] = totalcredit;
    data['otp'] = otp;
    data['datereg'] = datereg;
    return data;
  }
  void setTotalCredit(String value) {
    totalcredit = value;
  }
}