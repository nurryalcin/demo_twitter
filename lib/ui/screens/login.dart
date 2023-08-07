import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{

  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Kullanıcı adı boş olamaz';
                }
                return null;
              },
              onSaved: (value) {
                _username = value ?? '';
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Şifre'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Şifre boş olamaz';
                }
                return null;
              },
              onSaved: (value) {
                _password = value ?? '';
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                }
              },
              child: Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}