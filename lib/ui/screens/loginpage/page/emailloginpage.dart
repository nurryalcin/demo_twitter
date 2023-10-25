import 'package:flutter/material.dart';
import 'package:twitter/api_service/user_service.dart';
import 'package:twitter/ui/screens/loginpage/page/passwordloginpage.dart';
import 'package:twitter/ui/screens/welcomepage/welcome.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';

class EmailLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  int? _loggedInUserId;
  bool _isEmailEmpty = true;

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'E-posta adresi boş olamaz';
    }
    if (!isValidEmail(value)) {
      return 'Geçerli bir e-posta adresi giriniz';
    }
    return null;
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email);
  }

  void emailLogin() async {
    var user = await UserService().emailLogin(_email);

    if (user != null) {
      setState(() {
        _loggedInUserId = user.id;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PasswordLoginPage(email: _email),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Maalesef hesabınızı bulamadık"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            size: 25,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomePage(),
              ),
            );
          },
        ),
        title: CircleAvatar(
            radius: 25, backgroundImage: AssetImage('assets/images/logo.jpg')),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: TextWidget(
                  titleText1: 'Başlamak için ilk önce e posta adresini gir',
                  fontWeight: FontWeight.bold,
                  textSize: 30,
                  textColor: CardColor.titleColor,
                ),
              ),
              Center(
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'E-posta adresinizi giriniz',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                        _isEmailEmpty = _email.isEmpty;
                      });
                    },
                    validator: (value) => _validateEmail(value!),
                  ),
                ),
              ),
              Spacer(),
              Divider(
                color: CardColor.userColor,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed:  () {},
                      child: TextWidget(
                        titleText1: 'Şifrenizi mi Unuttunuz?',
                        fontWeight: FontWeight.bold,
                        textSize: 15,
                        textColor: CardColor.titleColor,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CardColor.fullScreenTitleColor,
                        minimumSize: Size(80, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _isEmailEmpty
                          ? null
                          : () {
                        if (_formKey.currentState!.validate()) {
                          emailLogin();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Lütfen hataları düzeltin'),
                            ),
                          );
                        }
                      },
                      child: Text('İleri'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CardColor.titleColor,
                        minimumSize: Size(80, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
