import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'form/Dashboard.dart';
import 'module/consts.dart';
import 'module/functions.dart';
import 'module/widget.dart';
import 'provider/mainProvider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>MainProvider())
      ],
      child: EasyLocalization(
        child: MyApp(), 
        supportedLocales: [Locale('en', 'US'), Locale('tr', 'TR')], 
        fallbackLocale: Locale('en', 'US'),
        path: 'lang'
      )
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: context.watch<MainProvider>().theme,
      home: context.watch<MainProvider>().user == null
        ? Login()
        : Dashboard()
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final _formkey = GlobalKey<FormState>();
    Map<String, String> _data = {'username': '', 'password': ''};

    List<Widget> footer(BuildContext context){
      return [
        context.watch<MainProvider>().status == UserStatus.Loading
          ? SizedBox(width: 100, child: CupertinoActivityIndicator())
          : Button(
              caption: 'login'.tr(),
              icon: Icon(Icons.lock_outline),
              onPressed: ()=>context.read<MainProvider>().authenticate(_data['username']!, _data['password']!)
            ),
        TxtButton(
          onPressed: ()=>showMessage(context: context, msg: 'msg.areyousure'.tr()),
          caption: '${'forgot password'.tr()}?'
        )
      ];
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: screenWidth(context) > 1024
            ? null
            : BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/background.png'),
                    fit: BoxFit.cover),
              ),
          child: Row(
            children: [
              screenWidth(context) > 1024
                ? Expanded(
                  flex: 1,
                  child: Container(
                    // color: Colors.blue.shade900,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark(context)
                          ? [
                              Colors.blueGrey.shade200,
                              Colors.blueGrey.shade400,
                              Colors.blueGrey.shade700,
                              Colors.blueGrey.shade900,
                            ]
                          : [
                              Colors.blue.shade200,
                              Colors.blue.shade400,
                              Colors.blue.shade700,
                              Colors.blue.shade900,
                            ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Label('welcome'.tr()).isBold().fontSize(78).fontFamily('pacifico').fontColor(Colors.white70),
                        Container(
                          height: screenHeight(context) * 0.7,
                          width: screenWidth(context) * 0.3,                         
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/background.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ))
                : Container(width: screenWidth(context) * 0.1),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth(context) <= 1115 && screenWidth(context) > 1024 
                        ? screenWidth(context) * 0.05 
                        : screenWidth(context) * 0.1
                      ),
                  child: Card(
                    elevation: 11,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      height: 435,
                      padding: EdgeInsets.all(18),
                      child: Form(
                        key: _formkey,
                        child: ListView(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  IButton(
                                    hint: 'English',
                                    asseimage: 'images/English.png',
                                    onPressed: () async => await context.setLocale(context.supportedLocales[0])
                                  ),
                                  SizedBox(width: 3),
                                  IButton(
                                    hint: 'Türkçe',
                                    asseimage: 'images/Turkey.png',
                                    onPressed: () async => await context.setLocale(context.supportedLocales[1])
                                  ),
                                  Spacer(),
                                  Switch(
                                    value: isDark(context), 
                                    onChanged: (val)=>context.read<MainProvider>().setTheme(val ? ThemeData.dark() : ThemeData.light())
                                  )
                                ],
                              ),
                            ),
                            CircleAvatar(
                              radius: 50,
                              child: ClipOval(
                                child: Image.asset('images/user.jpg', fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(height: 35),
                            EditBox(label: 'username'.tr(), notEmpty: true, onChange: (val)=>_data['username']=val),
                            EditBox(label: 'password'.tr(), notEmpty: true, password: true, onChange: (val)=>_data['password']=val),
                            
                            SizedBox(height: 25),
                            context.watch<MainProvider>().status == UserStatus.Failed
                              ? Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                padding: EdgeInsets.all(12),
                                child: Label('${context.read<MainProvider>().errMsg}').isBold().fontColor(Colors.white),
                              )
                              : Container(),
                            screenWidth(context) > 1365
                              ? Row(children: footer(context))
                              : Column(children: footer(context))
                          ],
                        ),
                      ),
                    )
                  )
               )
              ),
              screenWidth(context) <= 1024 ? Container(width: screenWidth(context) * 0.1) : Container()
            ]
          ),
        )
      ),
    );
  }
}
