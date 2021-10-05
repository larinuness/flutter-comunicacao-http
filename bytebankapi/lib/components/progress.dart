import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final String message;

  Progress({this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            color: Colors.green,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              message,
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
