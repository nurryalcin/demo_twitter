import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/widgets/titletext.dart';


class TextWidget extends StatefulWidget {
  final String titleText1;
  final FontWeight fontWeight;
  final double textSize;
  final Color textColor;

  const TextWidget({
    super.key,
    required this.titleText1,
    required this.fontWeight,
    required this.textSize,
    required this.textColor,
  });

  @override
  State<StatefulWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return TitleText(
      textName: widget.titleText1,
      textColor: widget.textColor,
      textWeight: widget.fontWeight,
      textSize: widget.textSize,
    );
  }
}
