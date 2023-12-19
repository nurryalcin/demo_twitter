import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/messagepage/sendmessage.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/provider.dart';
import 'package:twitter/model/user.dart';

class ChoosePerson extends StatelessWidget {
  const ChoosePerson({super.key, required this.isUserSelected, this.onPressed, this.user, });

  final bool isUserSelected;
  final VoidCallback? onPressed;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                iconSize: 45,
                onPressed: () {
                 
                },
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextWidget(
                  titleText1: 'New message',
                  fontWeight: FontWeight.bold,
                  textSize: 25, textColor:Provider.of<UserProfileProvider>(context).titleColor
                ),
              ),
              const SizedBox(width: 60,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  backgroundColor: isUserSelected ?Provider.of<UserProfileProvider>(context).userColor : Provider.of<UserProfileProvider>(context).titleColor,
                ),
                onPressed: isUserSelected
                    ? () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SendMessage(user: user,),
                    ),
                  );
                }
                    : null,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: TextWidget(
                    titleText1: 'Next',
                    fontWeight: FontWeight.bold,
                    textSize: 25,
                    textColor: Provider.of<UserProfileProvider>(context).fullScreenTitleColor
                  ),
                ),
              )






            ],
          ),
        ),

      ],
    );
  }
}
