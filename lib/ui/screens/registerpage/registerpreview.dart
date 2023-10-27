import 'package:flutter/material.dart';
import 'package:twitter/api_service/user_service.dart';
import 'package:twitter/utils/class.dart';
import 'package:twitter/ui/screens/welcomepage/welcome.dart';

class RegisterPreview extends StatefulWidget {
  final String username;
  final String fullname;
  final String email;
  final String password;

  const RegisterPreview({super.key, required this.username, required this.fullname, required this.email, required this.password});



  @override
  State<StatefulWidget> createState() => _RegisterPreviewState();
}

class _RegisterPreviewState extends State<RegisterPreview> {
  String _username = '';
  String _fullname = '';
  String _email = '';
  String _password = '';
  String? _avatarPhotoUrl='';

  @override
  void initState() {
    super.initState();

    _email= widget.email;
    _fullname=widget.fullname;
    _password=widget.password;
    _username=widget.username;
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
          MaterialPageRoute(builder: (context) => const WelcomePage()),
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(

          children: [
            Center(
              child: SizedBox(
                width: 350,
                child: TextField(
                  style: const TextStyle(fontSize: 23),
                  controller: TextEditingController(text: _username),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
            SizedBox(
              width: 350,
              child: TextField(
                style: const TextStyle(fontSize: 23),
                controller: TextEditingController(text: _fullname),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 350,
              child: TextField(
                style: const TextStyle(fontSize: 23),
                controller: TextEditingController(text: _email),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 350,
              child: TextField(
                style: const TextStyle(fontSize: 23),
                controller: TextEditingController(text: _password),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () => register(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: CardColor.titleColor,
                    minimumSize: const Size(350, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
                child: const Text('Kayıt Ol')),
          ],
        ),
      ),
    );
  }
}
