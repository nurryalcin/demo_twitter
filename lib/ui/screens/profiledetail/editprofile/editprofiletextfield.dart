import 'package:flutter/material.dart';
import 'package:twitter/utils/sharedpreferences.dart';
class EditProfileTextFieldWidget extends StatefulWidget {
  const EditProfileTextFieldWidget({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfileTextFieldWidgetState();
}

class _EditProfileTextFieldWidgetState extends State<EditProfileTextFieldWidget> {
  String? fullname;
  final TextEditingController _textEditingController = TextEditingController();

  Future<void> getFullname() async {
    UserPreferences userPreferences = UserPreferences();
    bool isLoggedIn = await userPreferences.isLoggedIn();

    if (isLoggedIn) {
      setState(() {
        fullname = userPreferences.getFullname();
        _textEditingController.text = fullname ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getFullname();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 350,
          child: TextField(
            style: const TextStyle(fontSize: 23),
            enabled: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            controller: _textEditingController,
          ),
        ),
      ],
    );
  }
}
