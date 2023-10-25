import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';

class MyProfileNameDate extends StatelessWidget {
  MyProfileNameDate(
      {super.key,
      required this.fullname,
      required this.username,
      required this.createdAt});

  String fullname;
  String username;
  String createdAt;

  String getFormattedDate() {
    if (createdAt != null) {
      final DateTime dateTime = DateTime.parse(createdAt!);
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
    if (fullname != null && username != null && createdAt != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              titleText1: fullname,
              fontWeight: FontWeight.bold,
              textSize: 25,
              textColor: CardColor.titleColor,
            ),
            TextWidget(
                titleText1: '@$username ',
                fontWeight: FontWeight.bold,
                textSize: 17,
                textColor: CardColor.userColor),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 20,
                    color: CardColor.userColor,
                  ),
                  TextWidget(
                      titleText1: "${getFormattedDate()}'te katıldı",
                      fontWeight: FontWeight.normal,
                      textSize: 18,
                      textColor: CardColor.userColor)
                ],
              ),
            )
          ],
        ),
      );
    }
    return SizedBox();
  }
}
