import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue.shade100,
      title: Row(
        children: <Widget>[
          Container(
            child: Image.asset("images/logo.jpeg"),
            width: 50.0,
            height: 50.0,
          ),
          Container(
            width: 50,
          ),
          Text("Palavra Viva"),
        ],
      ),
    );
  }
}
