import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
 class DrawerMenuModeButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return  IconButton(
     onPressed: () {
       Navigator.pop(context);
       showModalBottomSheet(
         context: context,
         builder: (context) {
           return Container(
             height: 200,
             child: Column(
               children: <Widget>[
                 ListTile(
                   leading: Icon(Icons.accessibility),
                   title: Text('Alt Menü Öğesi 1'),
                   onTap: () {
                   },
                 ),
                 ListTile(
                   leading: Icon(Icons.add),
                   title: Text('Alt Menü Öğesi 2'),
                   onTap: () {
                   },
                 ),
               ],
             ),
           );
         },
       );
     },
     icon: SvgPicture.asset('assets/images/sun.svg'),
   );
  }

}