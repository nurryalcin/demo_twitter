import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/messagepage/messagepageddetail.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/provider.dart';

class BodyMessageWidget extends StatelessWidget {
  const BodyMessageWidget({super.key,});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        TextWidget(
          titleText1: '',
          fontWeight: FontWeight.bold,
          textSize: 40, textColor:Provider.of<UserProfileProvider>(context).titleColor,),
        TextWidget(
          titleText1: '',
          fontWeight: FontWeight.bold,
          textSize: 40, textColor: Provider.of<UserProfileProvider>(context).titleColor,),
        const SizedBox(height: 20),
        TextWidget(
          titleText1:
          'Drop a line, share Tweets and more with  ',
          fontWeight: FontWeight.normal,
          textSize: 20, textColor: Provider.of<UserProfileProvider>(context).titleColor,),
        TextWidget(
            titleText1: 'private conversations between you and ',
            fontWeight: FontWeight.normal,
            textSize: 20,
            textColor: Provider.of<UserProfileProvider>(context).titleColor),
        TextWidget(titleText1: 'others on Twitter.',
            fontWeight: FontWeight.normal,
            textSize: 20,
            textColor: Provider.of<UserProfileProvider>(context).titleColor),
        const SizedBox(height: 20,),
        ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 225, height: 75),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagePageDetail(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: const Text(
              'Write a message',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),


      ],
    );
  }
}
