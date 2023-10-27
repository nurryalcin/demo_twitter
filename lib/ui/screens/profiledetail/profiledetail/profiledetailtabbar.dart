import 'package:flutter/material.dart';

class ProfileDetailTabbar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: TabBar(
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue,
                    width: 5.0,


                  ),
                ),
              ),

              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
              tabs: [
                Tab(text: 'Gönderiler',
                ),
                Tab(text: 'Yanıtlar',),
              ],
            ),
          ),

        ],
      ),
    );
  }

}