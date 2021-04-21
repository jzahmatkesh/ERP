import '../class/User.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

enum UserStatus{Initiale, Loading, Loaded, Failed}

class MainProvider extends ChangeNotifier{
  User? user;
  UserStatus status = UserStatus.Initiale;
  String? errMsg;

  ThemeData theme = ThemeData.light();

  authenticate(String username, String password) async{
    try{
      status = UserStatus.Loading;
      notifyListeners();
      Future.delayed(Duration(seconds: 3), (){
        if (username == "2" && password == "1"){
          status = UserStatus.Loaded;
          user = User.fromJson({'id': 1, 'family': 'Arman Zahmatkesh', 'mobile': '5349268654', 'email': 'info@zahmatkesh.dev', 'lastlogin': 'today', 'married': 1});
        }
        else{
          errMsg = "msg.wrongpassword".tr();
          status = UserStatus.Failed;
        }
        notifyListeners();
      });
    }
    catch(e){
      errMsg = "$e";
      status = UserStatus.Failed;
      notifyListeners();
    }
  }

  setTheme(ThemeData thm){
    theme = thm;
    notifyListeners();
  }
}