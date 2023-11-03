import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/addtweet/addtweet.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';
class AddTweetButton extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _AddTweetButtonState();

}
class _AddTweetButtonState extends State<AddTweetButton> {

  bool isOverlayVisible = false;
  IconData currentFabIcon = Icons.add;
  String currentFabText = "";

   void closeOverlay(BuildContext context) {
     setState(() {
     isOverlayVisible = false;
     currentFabIcon=Icons.add;
     currentFabText="";

     });
   }

   void _toggleOverlay() {
     setState(() {
       if (isOverlayVisible) {
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => const AddTweet()),
         );
       }
       isOverlayVisible = !isOverlayVisible;
       currentFabIcon = isOverlayVisible ? Icons.post_add : Icons.add;
       currentFabText = isOverlayVisible ? "Post" : "";
     });
   }




  @override
  Widget build(BuildContext context) {


    return Stack(children: [
      if (isOverlayVisible)
        GestureDetector(
          onTap: () {
            closeOverlay(context);
          },
          child: Container(
            color: Colors.white.withOpacity(0.8),
            child: Padding(
              padding: const EdgeInsets.only(left: 290,top:534),
              child: Column(
                  children: [
                Row(
                  children: [
                    TextWidget(
                        titleText1: 'Spaces',
                        fontWeight: FontWeight.normal,
                        textSize: 15,
                        textColor: CardColor.titleColor),
                    const SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      backgroundColor: CardColor.fullScreenTitleColor,
                      onPressed: () {},
                      child: Icon(
                        Icons.circle_outlined,
                        color: CardColor.iconColorblue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(children: [
                  TextWidget(
                      titleText1: 'Photos',
                      fontWeight: FontWeight.normal,
                      textSize: 15,
                      textColor: CardColor.titleColor),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                      backgroundColor: CardColor.fullScreenTitleColor,
                      onPressed: () {},
                      child: Icon(
                        Icons.photo_outlined,
                        color: CardColor.iconColorblue,
                        size: 30,
                      )),
                ]),
                const SizedBox(height: 16),
                Row(
                  children: [
                    TextWidget(
                        titleText1: 'GIF',
                        fontWeight: FontWeight.normal,
                        textSize: 15,
                        textColor: CardColor.titleColor),
                    const SizedBox(
                      width: 37,
                    ),
                    FloatingActionButton(
                      backgroundColor: CardColor.fullScreenTitleColor,
                      onPressed: () {},
                      child: Icon(
                        Icons.gif,
                        color: CardColor.iconColorblue,
                        size: 40,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      Positioned(
          right: 0,
          bottom: 0,
          child: Row(children: [
            if (currentFabText.isNotEmpty)
              Text(
                currentFabText,
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(width: 25),
            FloatingActionButton(
              onPressed: _toggleOverlay,
              child: Icon(
                currentFabIcon,
                size: 30,
              ),
            )
          ]))
    ]);
  }
}
