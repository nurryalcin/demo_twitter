import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/provider.dart';
import '../../../homepage/drawermenu/drawermenü.dart';
import '../../../widgets/avatarprofile.dart';
import '../../../widgets/titletext.dart';

class MessageAppbarWidget extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return  Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: DrawerMenu(),
                );
              },
            );
          },
          child: Consumer<UserProfileProvider>(
            builder: (context, userProfile, child) {
              return const AvatarProfile();
            },
          ),
        ),
        SizedBox(width: 30,),

        const SizedBox(width: 140),

      ],
    );
  }

}