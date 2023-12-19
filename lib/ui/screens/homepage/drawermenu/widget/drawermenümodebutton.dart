import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/provider.dart';
import 'package:twitter/utils/sharedpreferences.dart';

class DrawerMenuModeButton extends StatefulWidget {
  DrawerMenuModeButton({super.key, this.isDarkMode = false});

  bool isDarkMode;

  @override
  _DrawerMenuModeButtonState createState() => _DrawerMenuModeButtonState();
}

class _DrawerMenuModeButtonState extends State<DrawerMenuModeButton> {
  List<String> options = [
    'Kapalı',
    'Açık',
    'Cihaz Ayarlarını Kullan',
    'Karart',
    'Gece Modu',
  ];


  late int selectedOption;
  @override
  void initState() {
    super.initState();
    initSelectedOption();
  }


  Future<void> initSelectedOption() async {
    UserPreferences userPrefs = UserPreferences();
    selectedOption = await userPrefs.getSelectedOption();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<UserProfileProvider>(context);
    widget.isDarkMode = darkMode.isDarkMode;
    selectedOption = widget.isDarkMode ? 1 : 0;



    return IconButton(
      onPressed: () {
        Navigator.pop(context);
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SizedBox(
                  height: 460,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: TextWidget(
                          titleText1: 'Karanlık Mod',
                          fontWeight: FontWeight.bold,
                          textSize: 20,
                          textColor: darkMode.titleColor,
                        ),
                      ),
                      Divider(
                        height: 5,
                        color: darkMode.userColor,
                        thickness: 1,
                      ),
                      for (int i = 0; i <= 2; i++)
                        RadioListTile<int>(
                          title: Text(options[i]),
                          value: i,
                          groupValue: selectedOption,
                          onChanged: (int? value) {
                            setState(() {
                              selectedOption = value!;
                              switch (selectedOption) {
                                case 0:
                                  darkMode.isDarkMode = false;
                                  UserPreferences().setDarkMode(false);
                                  break;
                                case 1:
                                  darkMode.isDarkMode = true;
                                  UserPreferences().setDarkMode(true);
                                  break;
                                case 2:
                                  break;
                              }
                            });
                          },
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),
                      ListTile(
                        title: TextWidget(
                          titleText1: 'Karanlık Tema',
                          fontWeight: FontWeight.bold,
                          textSize: 20,
                          textColor: darkMode.titleColor,
                        ),
                      ),
                      for (int i = 3; i < 5; i++)
                        RadioListTile<int>(
                          title: Text(options[i]),
                          value: i,
                          groupValue: selectedOption,
                          onChanged: (int? value) {
                            setState(() {
                              selectedOption = value!;
                              switch (selectedOption) {
                                case 3:
                                  break;
                                case 4:
                                  break;
                              }
                            });
                          },
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      icon: SvgPicture.asset(widget.isDarkMode
          ? 'assets/images/moon.svg'
          : 'assets/images/sun.svg'),
    );
  }
}
