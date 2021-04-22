import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../module/consts.dart';
import '../module/widget.dart';
import '../provider/mainProvider.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user = context.read<MainProvider>().user!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Vema Textile'),
        centerTitle: true,
        actions: [Switch(value: isDark(context), onChanged: (val)=>context.read<MainProvider>().setTheme(val ? ThemeData.dark() : ThemeData.light()))],
      ),
      body: SafeArea(
        child: Row(
          children: [
            screenWidth(context) < 600 
              ? Container()
              : Card(
                  child: Container(
                    width: 225,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(CupertinoIcons.square_grid_2x2, size: 32),
                            Label('Vema Textile'.tr(), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 50),
                        MenuItem(caption: 'Home', icon: Icon(Icons.home_outlined), selected: true, onPressed: (){}),
                        SubMenuItem(icon: Icon(Icons.home_outlined), caption: 'Dashboard', onPressed: (){}),
                        SubMenuItem(icon: Icon(Icons.recent_actors_rounded), caption: 'put test data', onPressed: (){}),
                        MenuItem(caption: 'Fabric', icon: Icon(CupertinoIcons.doc_plaintext), selected: false, onPressed: (){}),
                        MenuItem(caption: 'Order', icon: Icon(CupertinoIcons.device_desktop), selected: false, onPressed: (){}),
                        MenuItem(caption: 'Production', icon: Icon(CupertinoIcons.rectangle_3_offgrid), selected: false, onPressed: (){}),
                      ],
                    )
                  ),
              ),
            Expanded(child: Center(
              child: Center(
                child: Column(
                  children: [
                    Card(
                      child: Container(
                        height: 75,
                        child: Row(
                          children: [
                            Label('Content'),
                            // user.family.toLabel(),
                            // user.family.toEdit(expanded: true),
                            // user.mobile.toLabel(),
                            // user.email.toLabel(),
                            // user.lastlogin.toLabel(),
                            // user.married.toMultiChoose(),
                            // Button(caption: 'to json', onPressed: ()=>showMessage(context: context, msg: '${user.toJson()}'))
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
      drawer: screenWidth(context) < 600 
        ? Drawer(
            child: Column(
              children: [
                Label('yes')
              ],
            ),
          )
        : null
    );
  }
}