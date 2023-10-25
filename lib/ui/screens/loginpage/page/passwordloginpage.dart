import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/homepage/homePage.dart';
import 'package:twitter/ui/screens/welcomepage/welcome.dart';
import 'package:twitter/ui/screens/widgets/bottomnavigationbarwidget.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/ui/screens/widgets/titletext.dart';
import 'package:twitter/utils/class.dart';
import '../../../../api_service/user_service.dart';
import '../../../../utils/provider.dart';
import '../../../../utils/sharedpreferences.dart';

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
          builder: (context) => const HomePage()
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
        title: const SizedBox(
          height: 40,
          width: 40,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo.jpg'),
            radius: 25,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 40, bottom: 25),
            child: TitleText(
                textName: 'Şifreni Gir',
                textColor: CardColor.titleColor,
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
                    backgroundColor: CardColor.fullScreenTitleColor,
                    minimumSize: const Size(80, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: TextWidget(
                    titleText1: 'Şifrenizi mi Unuttunuz?',
                    fontWeight: FontWeight.bold,
                    textSize: 15,
                    textColor: CardColor.titleColor,
                  ),
                ),
                ElevatedButton(
                  onPressed: _isEmptyPassword ? null : () => login(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isEmptyPassword
                        ? Colors.grey
                        : CardColor.titleColor,
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