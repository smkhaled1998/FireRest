import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String cardText;

  CardWidget({required this.cardText});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.down,

      background: Container(
        width: double.infinity,
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.edit, color: Colors.white),
            ),
            Text(
              "Edit",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          // Handle delete action
        } else {
          // Handle edit action
        }
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(cardText),
        ),
      ),
    );
  }
}