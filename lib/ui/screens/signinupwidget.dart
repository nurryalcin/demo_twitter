import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:twitter/ui/screens/welcome.dart';


class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {

  String? _profileImage;

  void _selectProfileImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage.path;
      });
    }
  }

  final _jsonFile = File('login.json');

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String birthDate = '';
      if (selectedDay != null && selectedMonth != null && selectedYear != null) {
        birthDate = '$selectedDay/$selectedMonth/$selectedYear';
      }

      if (!showPhoneNumber) {
        _phoneNumber = _eMail;
      }

      final userData = {
        'name': _userName,
        'email': _eMail,
        'phoneNumber': _phoneNumber,
        'birthDate': birthDate,
        'password': _password,
        'profileImage': _profileImage,
      };

      await _saveUserDataToJson(userData);

      print('Kayıt başarıyla tamamlandı.');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    }
  }

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


  Future<void> _saveUserDataToJson(Map<String, dynamic> userData) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/login.json');

    final jsonUserData = jsonEncode(userData);
    await file.writeAsString(jsonUserData);


  }





  bool showPhoneNumber = false;

  void toggleShowPhoneNumber() {
    setState(() {
      showPhoneNumber = !showPhoneNumber;
    });
  }

  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _password = '';
  String _phoneNumber = '';
  String _eMail = '';
  int? selectedDay;
  int? selectedMonth;
  int? selectedYear;



  List<int> daysInMonth(int year, int month) {
    final lastDay = DateTime(year, month + 1, 0).day;
    return List<int>.generate(lastDay, (index) => index + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kayıt Ol'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(top: 25, left: 15),
            child: Column(
                children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    if (!showPhoneNumber) {
                      _userName = value;
                    } else {
                      _phoneNumber = value;
                    }
                  });
                },
                validator: (value) {
                  if (!showPhoneNumber && (value == null || value.isEmpty)) {
                    return 'İsim kısmı boş olamaz';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'İsim',
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    if (!showPhoneNumber) {
                      _eMail = value;
                    } else {
                      _phoneNumber = value;
                    }
                  });
                },
                validator: (value) {
                  if (!showPhoneNumber && (value == null || value.isEmpty)) {
                    return ' E posta adresi boş olamaz.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: showPhoneNumber ? 'Telefon Numarası' : 'E Posta',
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: toggleShowPhoneNumber,
                    child: Text(showPhoneNumber
                        ? 'E Posta Kullan'
                        : 'Telefon Numarası Kullan'),
                  ),
                ],
              ),


              Text(
                showPhoneNumber ? _phoneNumber : _eMail,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    'Doğum Tarihinizi Seçiniz',
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    DropdownButton<int>(
                      hint: Text('Gün'),
                      value: selectedDay,
                      onChanged: (value) {
                        setState(() {
                          selectedDay = value;
                        });
                      },
                      items: daysInMonth(selectedYear ?? DateTime.now().year,
                              selectedMonth ?? DateTime.now().month)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 50),
                    DropdownButton<int>(
                      hint: Text('Ay'),
                      value: selectedMonth,
                      onChanged: (value) {
                        setState(() {
                          selectedMonth = value;
                        });
                      },
                      items: List.generate(12, (index) => index + 1)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 50),
                    DropdownButton<int>(
                      hint: Text('Yıl'),
                      value: selectedYear,
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value;
                        });
                      },
                      items: List.generate(
                              100, (index) => DateTime.now().year - index)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],


                ),
              ),
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
                    decoration: InputDecoration(labelText: 'Şifre Belirleyiniz'),
                  ),
                  ElevatedButton(
                    onPressed: _selectProfileImage,
                    child: Text('Profil Resmi Seç'),
                  ),
              Padding(
                padding: const EdgeInsets.only(left: 150,top:15),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: _login,
                      child: Text('Kayıt Ol'),

                    ),
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}


