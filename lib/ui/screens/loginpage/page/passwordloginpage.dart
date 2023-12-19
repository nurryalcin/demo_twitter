import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/welcomepage/welcome.dart';
import 'package:twitter/ui/screens/widgets/bottomnavigationbarwidget.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/ui/screens/widgets/titletext.dart';
import 'package:twitter/api_service/user_service.dart';
import 'package:twitter/utils/provider.dart';
import 'package:twitter/utils/sharedpreferences.dart';

class PasswordLoginPage extends StatefulWidget {
  final String email;

  const PasswordLoginPage({Key? key, required this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordLoginPageState();
}

class _PasswordLoginPageState extends State<PasswordLoginPage> {
  final TextEditingController _passwordController = TextEditingController();
  String _email = '';
  String _password = '';
  int? _loggedInUserId;
  bool _passwordVisible = false;
  bool _isEmptyPassword = true;

  @override
  void initState() {
    super.initState();
    _email = widget.email;
  }

  void login() async {
    final userPreferences = UserPreferences();
    final user = await UserService().login(_email, _password);

    if (user != null) {
      userPreferences.logIn(
          user.username, user.id, user.fullname, user.avatarPhotoUrl ?? "", user.createdAt,user.email);
      final userProfileProvider =
      Provider.of<UserProfileProvider>(context, listen: false);
      userProfileProvider.initUserProfile();
      setState(() {
        _loggedInUserId = user.id;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavigationBarWidget(index: 0)
        ),
      );

    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Girdiğiniz şifreye uygun kullanıcı bulunamadı'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<UserProfileProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 25,
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WelcomePage(),
                ));
          },
        ),
        centerTitle: true,
        title:  ClipOval(
          child: SizedBox(
              height: 40,
              width: 40,
              child: SvgPicture.asset(isDarkMode
                  ? 'assets/images/logo_dark.svg'
                  : 'assets/images/logo.svg')),

        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 40, bottom: 25),
            child: TitleText(
                textName: 'Şifreni Gir',
                textColor: Provider.of<UserProfileProvider>(context).titleColor,
                textWeight: FontWeight.bold,
                textSize: 35),
          ),
          Center(
            child: SizedBox(
              width: 350,
              child: TextField(
                style: const TextStyle(fontSize: 23),
                controller: TextEditingController(text: _email),
                enabled: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              width: 350,
              child: TextField(
                controller: _passwordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Şifre',
                  border: const OutlineInputBorder(),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    child: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                    _isEmptyPassword = _password.isEmpty;
                  });
                },
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
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
                    textColor: Provider.of<UserProfileProvider>(context).appbarColor,
                  ),
                ),
                ElevatedButton(
                  onPressed: _isEmptyPassword ? null : () => login(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isEmptyPassword
                        ? Provider.of<UserProfileProvider>(context).userColor
                        : Provider.of<UserProfileProvider>(context).titleColor,
                    minimumSize: const Size(60, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Giriş'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}