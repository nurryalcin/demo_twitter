import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter/api_service/user_service.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void apiLogin() async{
    var user = await UserService().login(_email, _password);
    if(user!= null){
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('user', jsonEncode(user));
      prefs.getString('user');
    }
    print(user?.id);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giriş Yap')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'E-mail boş olamaz';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'E-mail'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şifre boş olamaz';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Şifre'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed:() =>  apiLogin(),
                child: Text('Giriş Yap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
