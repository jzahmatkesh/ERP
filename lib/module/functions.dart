import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void showMessage({required BuildContext context, required String msg, DialogType type = DialogType.INFO, Function? okPress, Function? cancelPress}){
  AwesomeDialog(
    context: context,
    animType: AnimType.SCALE,
    dialogType: type,
    width: 450,
    body: Center(
      child: Text(
        '$msg',
        style: TextStyle(fontStyle: FontStyle.italic),
      )
    ),
    btnOkOnPress: okPress ?? (){},
    btnCancelOnPress: cancelPress,
    btnOkText: 'ok'.tr(),
    btnCancelText: 'cancel'.tr()
  )..show();
}