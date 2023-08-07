import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:twitter/ui/screens/widgets/listtweet.dart';
import 'dart:io';

import 'package:twitter/ui/screens/widgets/tweetwidget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _emailOrPhone = '';
  String _password = '';

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/login.json');
  }

  Future<Map<String, dynamic>> _readJson() async {
    try {
      final file = await _getLocalFile();
      final jsonString = await file.readAsString();
      final Map<String, dynamic> data = jsonDecode(jsonString);
      print('Okunan veriler: $data');
      return data;
    } catch (e) {
      print('Dosya okuma hatası: $e');
      return {};
    }
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final userData = await _readJson();
      print('userData: $userData');
      final emailOrPhoneFromData = userData['email'];
      final password = userData['password'];

      if (_emailOrPhone == emailOrPhoneFromData && _password == password) {
        print('Giriş başarılı');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListWidget()),
        );
      } else {
        print('Kullanıcı adı veya şifre hatalı');
      }
    }
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
                    _emailOrPhone = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'E-mail/Telefon boş olamaz';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'E-mail/Telefon'),
              ),
              SizedBox(height: 16),
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
                onPressed: _login,
                child: Text('Giriş Yap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

