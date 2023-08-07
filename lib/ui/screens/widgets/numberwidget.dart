import 'package:flutter/material.dart';



class NumberWidget extends StatelessWidget {
  const NumberWidget({
    super.key,
    required this.titleText, required this.numberColor,
  });

  final String titleText;
  final Color numberColor;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          titleText,
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
          style: TextStyle(
            color: numberColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              height: 2),
        ),
      ],
    );
  }
}
