import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/drawermen%C3%BC.dart';
import 'package:twitter/ui/screens/widgets/avatarprofile.dart';
import 'package:twitter/utils/provider.dart';

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 110.0;

  @override
  double get minExtent => 15.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    bool isDarkMode = Provider.of<UserProfileProvider>(context).isDarkMode;

    return AppBar(
      leading: GestureDetector(
        onTap: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Align(
                alignment: AlignmentDirectional.centerStart,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: DrawerMenu()),
              );
            },
          );
        },
        child: Consumer<UserProfileProvider>(
          builder: (context, userProfile, child) {
            return const Padding(
              padding: EdgeInsets.all(12.0),
              child: AvatarProfile(),
            );
          },
        ),
      ),
      centerTitle: true,
      title: ClipOval(
        child: SizedBox(
            height: 40,
            width: 40,
            child: SvgPicture.asset(isDarkMode
                ? 'assets/images/logo_dark.svg'
                : 'assets/images/logo.svg')),
      ),
    );
  }
}
