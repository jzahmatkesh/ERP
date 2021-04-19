import 'package:erpui/module/consts.dart';
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
          child: Row(children: [
        // Align(
        //     alignment: Alignment.centerLeft,
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
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Wellcome',
                    style: TextStyle(fontSize: 38, color: Colors.white),
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
            )),
        // Align(
        //     alignment: Alignment.centerRight,
        Expanded(
            // margin: EdgeInsets.only(right: screenWidth(context) * 0.10),
            child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth(context) * 0.15),
                child: Card(
                    elevation: 11,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      // decoration: BoxDecoration(
                      //     color: Colors.grey.shade100,
                      //     borderRadius: BorderRadius.circular(12)),
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
                          TextFormField(
                            autofocus: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                labelText: 'username'),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                labelText: 'password'),
                          ),
                          SizedBox(height: 25),
                          Row(
                            children: [
                              ElevatedButton(
                                  child: Text('Login'), onPressed: () {}),
                              SizedBox(width: 10),
                              TextButton(
                                  onPressed: () {},
                                  child: Text('forgot password?'))
                            ],
                          )
                        ],
                      ),
                    )))),
      ])),
    );
  }
}
