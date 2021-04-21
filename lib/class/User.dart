import 'BaseClass.dart';
import 'package:easy_localization/easy_localization.dart';

class User extends Entity{
  late Field<int> id;
  late Field<String> family;
  late Field<String> mobile;
  late Field<String> email;
  late Field<String> lastlogin;
  late Field<int> married;

  @override
  User.fromJson(Map<String, dynamic> json) : super.fromJson(json){
    id = Field(fieldName: 'id', fieldLabel: 'field.id'.tr(), value: json['id']);
    family = Field(fieldName: 'family', fieldLabel: 'field.family'.tr(), value: json['family']);
    mobile = Field(fieldName: 'mobile', fieldLabel: 'field.mobile'.tr(), value: json['mobile']);
    email = Field(fieldName: 'email', fieldLabel: 'field.email'.tr(), value: json['email']);
    lastlogin = Field(fieldName: 'lastlogin', fieldLabel: 'field.lastlogin'.tr(), value: json['lastlogin']);
    married = Field(fieldName: 'married', fieldLabel: 'field.married'.tr(), value: json['married'], options: [{'id': 1, 'name': 'single'}, {'id': 2, 'name': 'married'}]);
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {
      'id': this.id.value,
      'family': this.family.value,
      'mobile': this.mobile.value,
      'email': this.email.value,
      'lastlogin': this.lastlogin.value,
      'married': this.married.value,
    };
    return _data;
  }
  
}