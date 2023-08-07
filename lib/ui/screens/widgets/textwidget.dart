import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/widgets/titletext.dart';

import '../../../utils/class.dart';



class TextWidget extends StatefulWidget {

  final String titleText1;
  final FontWeight fontWeight;
  final double textSize;



  const TextWidget({
    super.key,
    required this.titleText1, required this.fontWeight, required this.textSize,


  });

  @override
  State<StatefulWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(

                child: TitleText(
                  textName: widget.titleText1,
                  textColor: CardColor.titleColor,
                  textWeight: widget.fontWeight,
                  textSize: widget.textSize,
                ),
              ),
            ],
          ),


        ],
      ),
    );
  }
}
