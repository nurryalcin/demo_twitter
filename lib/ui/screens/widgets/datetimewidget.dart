import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/widgets/titletext.dart';
import '../../../utils/class.dart';

class DateTimeWidget extends StatefulWidget {
  final int views;
  final DateTime dateTime;
  final Color numberColor;

  const DateTimeWidget(
      {Key? key,
      required this.views,
      required this.dateTime,
      required this.numberColor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  late Timer _timer;
  final Random _random = Random();
  int prevViewsCount = 0;

  int getRandom(int prevCount) {
    int randomNumber;
    do {
      randomNumber = _random.nextInt(999999999 - 1000) + 1000;
    } while (randomNumber <= prevCount);
    return randomNumber;
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _stopTimer();
  }

  void _startTimer() =>
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        setState(() {});
      });

  void _stopTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    int views = getRandom(prevViewsCount);

    prevViewsCount = views;

    String getAbbreviatedNumber(int number) {
      if (number >= 1000000000) {
        return '${(number ~/ 1000000000)}B';
      } else if (number >= 1000000) {
        return '${(number ~/ 1000000)}M';
      } else if (number >= 1000) {
        return '${(number ~/ 1000)}K';
      } else {
        return '$number';
      }
    }

    // ignore: unused_local_variable
    DateTime now = DateTime.now();
    String getTime() {
      return DateFormat('h:mm a').format(widget.dateTime);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          TitleText(
              textName: getTime(),
              textColor: CardColor.userColor,
              textWeight: FontWeight.normal, textSize: 18,),
          TitleText(
              textName: '  ${getAbbreviatedNumber(widget.views)}',
              textColor: widget.numberColor,
              textWeight: FontWeight.bold, textSize: 18,),
          TitleText(
              textName: ' Views',
              textColor: CardColor.userColor,
              textWeight: FontWeight.normal, textSize: 18,)
        ],
      ),
    );
  }
}
