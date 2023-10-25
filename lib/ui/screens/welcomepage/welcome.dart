import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/loginpage/page/emailloginpage.dart';
import 'package:twitter/ui/screens/registerpage/signupwidget.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';



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
    return Scaffold(
      backgroundColor: CardColor.fullScreenTitleColor,
      body:Padding(
        padding:  EdgeInsets.only(top: 300),
        child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(50, 50),
                        side: BorderSide(color: CardColor.titleColor),
                        backgroundColor: CardColor.fullScreenTitleColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: _goToLoginPage,
                      child: TextWidget(
                        titleText1: 'Giriş',
                        fontWeight: FontWeight.bold,
                        textSize: 20,
                        textColor: CardColor.titleColor,
                      ),
                    ),

                  )
                ],
              ),
              SizedBox(height: 25,),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(50, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                        onPressed: (_goToSignUpPage),
                        child: TextWidget(
                            titleText1: 'Kayıt Ol',
                            fontWeight: FontWeight.bold,
                            textSize: 20, textColor: CardColor.titleColor, ),
                      ))
                ],
              )
            ],
          ),

      ),
    );




  }
}
