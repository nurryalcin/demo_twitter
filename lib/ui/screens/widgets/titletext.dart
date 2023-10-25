import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.textName,
    required this.textColor,
    required this.textWeight,
    required this.textSize,

  });

  final String textName;
  final Color textColor;
  final FontWeight textWeight;
  final double textSize;


  @override
  Widget build(BuildContext context) {
    return Text(
      textName,
      softWrap: true,
      style: TextStyle(
        color: textColor,
        fontWeight: textWeight,
        fontSize: textSize,
      ),
    );

  }
}

