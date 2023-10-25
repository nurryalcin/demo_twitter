import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter/ui/screens/registerpage/registerpreview.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  String? _profileImage;
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _fullname = '';
  String _email = '';
  String _password = '';
  String? _avatarPhotoUrl = '';

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email);
  }

  void register() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterPreview(
                  password: _password,
                  username: _username,
                  fullname: _fullname,
                  email: _email,
                )),
      );
    }
  }

  void _selectProfileImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 25,
          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(right: 130, top: 25),
              child: TextWidget(
                  titleText1: 'Hesabını oluştur',
                  fontWeight: FontWeight.bold,
                  textSize: 30,
                  textColor: CardColor.titleColor),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 350,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Kullanıcı Adı',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _username = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kullanıcı adı boş olamaz';
                  }
                  if (value.length < 5) {
                    return 'Kullanıcı adı en az 5 karakter olmalıdır';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 350,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'İsim',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _fullname = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'İsim boş olamaz';
                  }
                  if (value.length < 5) {
                    return 'İsim en az 5 karakter olmalıdır';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 350,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'E Mail',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _email = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'E-posta adresi boş olamaz.';
                  }
                  if (!isValidEmail(value)) {
                    return 'Geçerli bir e-posta adresi giriniz';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 350,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Şifre',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _password = value;
                },
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şifre boş olamaz';
                  }
                  if (value.length < 4) {
                    return 'Şifre en az 4 karakter olmalıdır';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: _selectProfileImage,
                child: const Text('Profil Resmi Seç'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: CardColor.titleColor,
                    minimumSize: Size(350, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ))),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ElevatedButton(
                  onPressed: () => register(),
                  child: Text('İleri'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: CardColor.titleColor,
                      minimumSize: Size(350, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ))),
            )
          ]),
        ),
      ),
    ));
  }
}
