import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyHomePage1 extends StatelessWidget {
  const MyHomePage1 ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
     
      body:  Align(
        alignment: Alignment.center,
        child: Text('home Screen',
        
        style: TextStyle(
          color: Colors.green,
          fontSize: 32
        ),
        ),
      ),
    );
  }
}