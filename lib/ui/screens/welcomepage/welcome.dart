import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/loginpage/page/emailloginpage.dart';
import 'package:twitter/ui/screens/loginpage/registerpage/signupwidget.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  void _goToLoginPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmailLoginPage()),
    );
  }

  void _goToSignUpPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpWidget()),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<UserProfileProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: ClipOval(
          child: SizedBox(
            height: 30,
            width: 30,
            child: ClipOval(
              child: SizedBox(
                  height: 40,
                  width: 40,
                  child: SvgPicture.asset(isDarkMode
                      ? 'assets/images/logo_dark.svg'
                      : 'assets/images/logo.svg')),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 250, right: 100, left: 15, bottom: 150),
            child: TextWidget(
                titleText1: 'See what\'s happening in the world right now',
                fontWeight: FontWeight.bold,
                textSize: 35,
                textColor:
                    Provider.of<UserProfileProvider>(context).titleColor),
          ),
          ElevatedButton(
            onPressed: () {
              _goToSignUpPage();
            },
            child: TextWidget(
                titleText1: 'Create account',
                fontWeight: FontWeight.bold,
                textSize: 20,
                textColor:
                    Provider.of<UserProfileProvider>(context).appbarColor),
            style: ButtonStyle(
                minimumSize: MaterialStatePropertyAll(Size(400, 40)),
                backgroundColor: MaterialStateProperty.all(
                    Provider.of<UserProfileProvider>(context).titleColor),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)))),
          ),
            SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                  titleText1: 'Have an account already?',
                  fontWeight: FontWeight.normal,
                  textSize: 20,
                  textColor:
                      Provider.of<UserProfileProvider>(context).userColor),
              TextButton(
                  onPressed: () {
                    _goToLoginPage();
                  },
                  child: TextWidget(
                      titleText1: 'Log In',
                      fontWeight: FontWeight.normal,
                      textSize: 20,
                      textColor: Provider.of<UserProfileProvider>(context).iconColorBlue))
            ],
          ),
        ],
      ),
    );
  }
}
