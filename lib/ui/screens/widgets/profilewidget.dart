import 'dart:io';

import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/widgets/titletext.dart';
import '../../../utils/class.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    super.key,
    required this.titleText,
    required this.titleTextColor,
    required this.usernameText,
    required this.usernameTextColor,
    required this.avatarImage,
   required this.menuColor,
  });

  final String titleText;
  final Color titleTextColor;
  final String usernameText;
  final Color usernameTextColor;
  final String avatarImage;
  final Color menuColor;

  @override
  State<StatefulWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Unfollow', 'icon': Icons.person_add},
    {'name': 'Add/Remove', 'icon': Icons.add_card},
    {'name': 'Mute', 'icon': Icons.volume_off_outlined},
    {'name': 'Mute this conversation', 'icon': Icons.volume_off_outlined},
    {'name': 'Block', 'icon': Icons.block},
    {'name': 'Embed Tweet', 'icon': Icons.tag_rounded},
    {'name': 'Report Tweet', 'icon': Icons.flag},
    {'name': 'View hidden replies', 'icon': Icons.insert_page_break_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: widget.avatarImage != null
                      ? DecorationImage(
                    image: FileImage(File(widget.avatarImage!)),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),

              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 15, bottom: 50),
                child: Column(
                  children: [
                    TitleText(
                      textName: widget.titleText,
                      textColor: widget.titleTextColor,
                      textWeight: FontWeight.bold, textSize: 18,
                    ),
                    TitleText(
                        textName: widget.usernameText,
                        textColor: widget.usernameTextColor,
                        textWeight: FontWeight.normal, textSize: 18,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 30),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: CardColor.iconColorblue,
                    )
                  ],
                ),
              )
            ],
          ),
          PopupMenuButton<String>(
            icon: Transform.rotate(
              angle: 3.14 / 2,
              child:  Icon(Icons.more_vert,color: widget.menuColor,),
            ),
            onSelected: (String result) {},
            itemBuilder: (BuildContext Context) {
              return menuItems.map((item) {
                IconData icon = item['icon'];
                String option = item['name'];

                return PopupMenuItem<String>(
                  value: option,
                  child: Row(
                    children: [
                      Icon(icon),
                      const Padding(padding: EdgeInsets.only(left: 15)),
                      Text(
                        option,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }).toList();
            },
          )
        ],
      ),
    );
  }
}
