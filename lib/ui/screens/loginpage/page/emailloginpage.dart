import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:twitter/api_service/user_service.dart';
import 'package:twitter/ui/screens/loginpage/page/passwordloginpage.dart';
import 'package:twitter/ui/screens/welcomepage/welcome.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/provider.dart';

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
        const SnackBar(
          content: Text("Maalesef hesabınızı bulamadık"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<UserProfileProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            size: 25,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomePage(),
              ),
            );
          },
        ),
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
        )
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
                  textColor: Provider.of<UserProfileProvider>(context).titleColor,
                ),
              ),
              Center(
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                    decoration: const InputDecoration(
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
              const Spacer(),
              Divider(
                color: Provider.of<UserProfileProvider>(context).userColor
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed:  () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Provider.of<UserProfileProvider>(context).fullScreenTitleColor,
                        minimumSize: const Size(80, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: TextWidget(
                        titleText1: 'Şifrenizi mi Unuttunuz?',
                        fontWeight: FontWeight.bold,
                        textSize: 15,
                        textColor: Provider.of<UserProfileProvider>(context).appbarColor
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
                            const SnackBar(
                              content: Text('Lütfen hataları düzeltin'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Provider.of<UserProfileProvider>(context).titleColor,
                        minimumSize: const Size(80, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('İleri'),
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
