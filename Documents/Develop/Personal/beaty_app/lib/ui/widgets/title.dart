import 'package:flutter/material.dart';

Widget TitleComtainer(
    String title, double containersize, BuildContext context, bool back) {
  return Container(
    color: Colors.indigo[900],
    height: containersize,
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        (back
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : Text('')),
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            title,
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
