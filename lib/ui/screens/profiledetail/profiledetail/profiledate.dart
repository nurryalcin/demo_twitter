import 'package:flutter/material.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import '../../../../utils/class.dart';
import '../../widgets/textwidget.dart';


class ProfileDate extends StatelessWidget{
  const ProfileDate({super.key, required this.tweet});

  final TweetWithProfile? tweet;

  String getFormattedDate() {
    if (tweet!.createdAt != null) {
      final DateTime dateTime = DateTime.parse(tweet!.createdAt!);
      final String formattedDate =
          "${_getMonthName(dateTime.month)} ${dateTime.year}";
      return formattedDate;
    } else {
      return "";
    }
  }
  static const Map<int, String> _monthNames = {
    1: "Ocak",
    2: "Şubat",
    3: "Mart",
    4: "Nisan",
    5: "Mayıs",
    6: "Haziran",
    7: "Temmuz",
    8: "Ağustos",
    9: "Eylül",
    10: "Ekim",
    11: "Kasım",
    12: "Aralık",
  };
  String _getMonthName(int month) {
    return _monthNames[month] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    if (tweet != null) {
      return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 15),
          child: Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                size: 25,
              ),
              Padding(padding: EdgeInsets.only(left: 12)),
              TextWidget(
                  titleText1:  "${getFormattedDate()}'te katıldı",
                  fontWeight: FontWeight.bold,
                  textSize: 20,
                  textColor: CardColor.userColor)
            ],
          ),
        )
      ],
    );
    } else {
      return SizedBox();
    }
  }
}