import 'BaseClass.dart';

class User extends Entity{
  late int id;
  late String family;
  late String mobile;
  late String email;
  late String lastlogin;
  late int married;

  @override
  User.fromJson(Map<String, dynamic> json) : super.fromJson(json){
    id = json['id'];
    family = json['family'];
    mobile = json['mobile'];
    email = json['email'];
    lastlogin = json['lastlogin'];
    married = json['married'];
    //, options: [{'id': 1, 'name': 'single'}, {'id': 2, 'name': 'married'}];
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {
      'id': this.id,
      'family': this.family,
      'mobile': this.mobile,
      'email': this.email,
      'lastlogin': this.lastlogin,
      'married': this.married,
    };
    return _data;
  }
  
}