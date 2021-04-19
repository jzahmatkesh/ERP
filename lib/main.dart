import 'package:erpui/module/consts.dart';
import 'package:erpui/module/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
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
                      'Welcome',
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
              )
            ),
            Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth(context) * 0.15),
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
                            Row(
                              children: [
                                Button(
                                  caption: 'Login',
                                  icon: Icon(Icons.lock_outline),
                                  onPressed: () {}
                                ),
                                TxtButton(
                                  onPressed: () {},
                                  caption: 'forgot password?'
                                )
                              ],
                            )
                          ],
                        ),
                      )))),
      ])),
    );
  }
}
