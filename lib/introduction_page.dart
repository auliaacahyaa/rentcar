import 'package:flutter/material.dart';
import 'package:rentcar/login.dart';

class IntroductionPage extends StatefulWidget {
  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    final mySnackBar = SnackBar(
      content: Text("Memulai"),
      duration: Duration(seconds: 1),
      padding: EdgeInsets.all(10),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Untitled.jpg'), // Replace with your background image asset
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/b790c867a12855ea7bcac8517c230283.jpg', width: 300, height: 300),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
                },
                child: Text("Start"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}