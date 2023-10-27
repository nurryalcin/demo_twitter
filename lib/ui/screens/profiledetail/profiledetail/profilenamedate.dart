import 'package:flutter/material.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';

class ProfileNameDate extends StatelessWidget {
  const ProfileNameDate({super.key, this.tweet});

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
      return Padding(
        padding: const EdgeInsets.only(left:20, right:15,bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
               padding: EdgeInsets.only(left: 5),
              child: TextWidget(
                titleText1: tweet!.fullname,
                fontWeight: FontWeight.bold,
                textSize: 20,
                textColor: CardColor.titleColor,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 5),
              child: TextWidget(
                  titleText1: '@${tweet!.username} ',
                  fontWeight: FontWeight.bold,
                  textSize: 20,
                  textColor: CardColor.userColor),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5,top: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: TextWidget(
                        titleText1:  "${getFormattedDate()}'te katıldı",
                        fontWeight: FontWeight.bold,
                        textSize: 15,
                        textColor: CardColor.userColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox();
  }
}
