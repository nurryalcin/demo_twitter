import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/loginpage/registerpage/registerpreview.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/provider.dart';

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
    bool isDarkMode = Provider.of<UserProfileProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
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
        padding: const EdgeInsets.only(top: 80, right: 25, left: 25),
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
                    textColor:
                        Provider.of<UserProfileProvider>(context).titleColor),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  decoration: const InputDecoration(
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
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  decoration: const InputDecoration(
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
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  decoration: const InputDecoration(
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
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                  decoration: const InputDecoration(
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
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: _selectProfileImage,
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Provider.of<UserProfileProvider>(context).titleColor,
                      minimumSize: const Size(350, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  child: TextWidget(
                      titleText1: 'Profil Resmi Seç',
                      fontWeight: FontWeight.normal,
                      textSize: 18,
                      textColor: Provider.of<UserProfileProvider>(context)
                          .appbarColor)),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ElevatedButton(
                    onPressed: () => register(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Provider.of<UserProfileProvider>(context)
                                .titleColor,
                        minimumSize: const Size(350, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                    child: TextWidget(
                        titleText1: 'İleri',
                        fontWeight: FontWeight.normal,
                        textSize: 18,
                        textColor: Provider.of<UserProfileProvider>(context)
                            .appbarColor)),
              )
            ]),
          ),
        ),
      ),
    ));
  }
}
