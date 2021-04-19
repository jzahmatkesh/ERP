import 'package:erpui/module/consts.dart';
import 'package:erpui/module/widget.dart';
import 'package:erpui/provider/mainProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>MainProvider())
      ],
      child: MyApp(),
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
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
                        colors: [
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
                        Text(
                          'welcome',
                          style: TextStyle(
                            fontFamily: 'pacifico',
                            fontSize: 78, 
                            color: Colors.white70
                          ),
                        ),
                        Container(
                          height: screenHeight(context) * 0.7,
                          width: screenWidth(context) * 0.3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/background.png'),
                                fit: BoxFit.cover),
                          ),
                        )
                      ],
                    ),
                  ))
                : Container(width: screenWidth(context) * 0.1),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth(context) <= 1115 && screenWidth(context) > 1024 ? screenWidth(context) * 0.05 : screenWidth(context) * 0.1),
                  child: Card(
                    elevation: 11,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(18),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage('http://i.imgur.com/ryybk8P.jpg'),
                          ),
                          SizedBox(height: 35),
                          EditBox(label: 'username'),
                          EditBox(label: 'password', password: true),
                          SizedBox(height: 25),
                          screenWidth(context) > 1365
                            ? Row(children: footer())
                            : Column(children: footer())
                        ],
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

  List<Widget> footer(){
    return [
      Button(
        caption: 'Login',
        icon: Icon(Icons.lock_outline),
        onPressed: () {}
      ),
      TxtButton(
        onPressed: () {},
        caption: 'forgot password?'
      )
    ];
  }
}
