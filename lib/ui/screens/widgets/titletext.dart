import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText(
      {super.key,
      required this.textName,
      required this.textColor,
      required this.textWeight,
      required this.textSize});

  final String textName;
  final Color textColor;
  final FontWeight textWeight;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            Text(
              textName,
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: textColor,
                  fontWeight: textWeight,
                  fontSize: textSize,
                  height: 2),
            ),
          ],
        )
      ],
    );
  }
}
