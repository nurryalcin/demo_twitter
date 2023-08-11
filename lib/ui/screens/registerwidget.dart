import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter/ui/screens/welcome.dart';
import 'package:twitter/api_service/user_service.dart';


class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {

  String? _profileImage;
   final _formKey= GlobalKey<FormState>();
   String _username= '';
   String _fullname = '';
   String _email = '';
   String _password='';
   String? _avatarPhotoUrl= '';



  void register() async {
    if (_formKey.currentState!.validate()) {


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
            MaterialPageRoute(builder: (context) => WelcomePage()),
          );
        } else {
          print('Kayıt işlemi başarısız.');
        }
      } catch (e) {
        print('Hata: $e');
      }
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
        appBar: AppBar(
          title: const Text('Kayıt Ol'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 15),
              child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        _username=value;

                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kullanıcı adı kısmı boş olamaz';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Kullanıcı Adı',
                      ),
                    ),
                    TextFormField(
                      onChanged: (_fullname) {},
                      validator: (_fullname) {
                        if ( _fullname == null || _fullname.isEmpty) {
                          return ' İsim kısmı boş olamaz';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'İsim',
                      ),
                    ),
                    TextFormField(
                      onChanged: (_email) {},
                      validator: (_email) {
                        if (_email  == null || _email.isEmpty) {
                          return ' E mail adresi boş olamaz.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'E mail'
                      ),
                    ),
                    TextFormField(
                      onChanged: (_password) {},
                      obscureText: true,
                      validator: (_password) {
                        if (_password == null || _password.isEmpty) {
                          return 'Şifre boş olamaz';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Şifre '),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: _selectProfileImage,
                        child: const Text('Profil Resmi Seç'),
                      ),

                    Padding(
                      padding: const EdgeInsets.only(left: 150,top:15),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed:() => register(),
                            child: Text('Kayıt Ol'),

                          ),
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        ));

  }
  }











