import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageDetailsTableItem extends StatelessWidget {
  final String tableText;
  bool isBold = false;

  ImageDetailsTableItem(this.tableText, {this.isBold});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Text(tableText,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)));
  }
}
