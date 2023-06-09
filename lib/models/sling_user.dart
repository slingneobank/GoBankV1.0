class SlingUser {
/*
{
  "name": "",
  "email": "",
  "dob": "",
  "pin": "",
  "mobile": "",
  "gender": "",
  "pic": "",
  "kyc_done": true,
  "activated": true
} 
*/

  String? name;
  String? email;
  String? dob;
  String? pin;
  String? mobile;
  String? gender;
  String? pic;
  bool? kycDone;
  bool? activated;

  SlingUser({
    this.name,
    this.email,
    this.dob,
    this.pin,
    this.mobile,
    this.gender,
    this.pic,
    this.kycDone,
    this.activated,
  });
  SlingUser.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    email = json['email']?.toString();
    dob = json['dob']?.toString();
    pin = json['pin']?.toString();
    mobile = json['mobile']?.toString();
    gender = json['gender']?.toString();
    pic = json['pic']?.toString();
    kycDone = json['kyc_done'];
    activated = json['activated'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['dob'] = dob;
    data['pin'] = pin;
    data['mobile'] = mobile;
    data['gender'] = gender;
    data['pic'] = pic;
    data['kyc_done'] = kycDone;
    data['activated'] = activated;
    return data;
  }
}
