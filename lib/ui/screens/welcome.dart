import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/signinupwidget.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'login.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  void _goToLoginPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
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
    return Padding(
      padding: const EdgeInsets.only(top: 300),
      child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                          )
                      ), onPressed: (_goToLoginPage),
                      child: const TextWidget(
                          titleText1: 'Giriş',
                          fontWeight: FontWeight.bold,
                          textSize: 20)),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                          )
                      ),
                      onPressed: (_goToSignUpPage),
                      child: TextWidget(
                          titleText1: 'Kayıt Ol',
                          fontWeight: FontWeight.bold,
                          textSize: 20),
                    ))
              ],
            )
          ],
        ),

    );




  }
}
