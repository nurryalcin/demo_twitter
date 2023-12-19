import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:twitter/api_service/user_service.dart';
import 'package:twitter/ui/screens/homepage/homePage.dart';
import 'package:twitter/ui/screens/loginpage/widget/customtextfield.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/provider.dart';

class RegisterPreview extends StatefulWidget {
  final String username;
  final String fullname;
  final String email;
  final String password;

  const RegisterPreview(
      {super.key,
      required this.username,
      required this.fullname,
      required this.email,
      required this.password});

  @override
  State<StatefulWidget> createState() => _RegisterPreviewState();
}

class _RegisterPreviewState extends State<RegisterPreview> {
  String _username = '';
  String _fullname = '';
  String _email = '';
  String _password = '';
  String? _avatarPhotoUrl = '';

  @override
  void initState() {
    super.initState();

    _email = widget.email;
    _fullname = widget.fullname;
    _password = widget.password;
    _username = widget.username;
  }

  void register() async {
    try {
      var user = await UserService().register(
        _username,
        _fullname,
        _avatarPhotoUrl!,
        _email,
        _password,
      );

      if (user != null) {
        print('Kayıt başarıyla tamamlandı.');

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        print('Kayıt işlemi başarısız.');
      }
    } catch (e) {
      print('Hata: $e');
    }
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
              height: 40,
              width: 40,
              child: SvgPicture.asset(isDarkMode
                  ? 'assets/images/logo_dark.svg'
                  : 'assets/images/logo.svg')),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, right: 15, left: 30),
          child: Column(
            children: [
              CustomTextField(labelText: 'Username', initialValue: _username),
              const SizedBox(height: 25),
              CustomTextField(labelText: 'Fullname', initialValue: _fullname),
              const SizedBox(height: 25),
              CustomTextField(labelText: 'Email', initialValue: _email),
              const SizedBox(height: 25),
              CustomTextField(labelText: 'Password', initialValue: _password),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () => register(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Provider.of<UserProfileProvider>(context).iconColorBlue,
                    minimumSize: const Size(350, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child:  TextWidget(
                      titleText1: 'Register',
                      fontWeight: FontWeight.bold,
                      textSize: 20,
                      textColor: Provider.of<UserProfileProvider>(context).whiteColor,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
