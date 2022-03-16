import 'package:flutter/material.dart';

class result extends StatelessWidget {
  final int marks;
  result({required this.marks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                child: Text(
                    "RESULT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ),
              Container(
                child: Text("Your Score is ${marks}"),
              )
            ],
          )
        ],
      ),
    );
  }
}
