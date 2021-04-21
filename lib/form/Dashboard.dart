import 'package:erpui/module/functions.dart';
import 'package:erpui/module/widget.dart';
import 'package:erpui/provider/mainProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.read<MainProvider>().user!;
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(child: Center(child: Text('side bar'))),
            Expanded(flex: 4, child: Center(
              child: Center(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      child: Container(
                        height: 75,
                        child: Row(
                          children: [
                            user.family.toLabel(),
                            user.mobile.toLabel(),
                            user.email.toLabel(),
                            user.lastlogin.toLabel(),
                            user.married.toMultiChoose(),
                            Button(caption: 'to json', onPressed: ()=>showMessage(context: context, msg: '${user.toJson()}'))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            )),
          ],
        )
      ),
    );
  }
}