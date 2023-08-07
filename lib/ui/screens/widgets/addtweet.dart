import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:twitter/ui/screens/widgets/tweetwidget.dart';

class AddTweet extends StatefulWidget {
  const AddTweet({
    Key? key,
    this.avatarPictureUri,
    this.userName,
    this.userUniqueName,
  }) : super(key: key);

  final avatarPictureUri;
  final userName;
  final userUniqueName;



  @override
  State<StatefulWidget> createState() => _AddTweetState();
}

class _AddTweetState extends State<AddTweet> {
  File? _image;
  DateTime? _selectedDate;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _selectedDate = DateTime.now();
      });
    }
  }

  List<Tweet> _savedTweets = [];

  @override
  void initState() {
    super.initState();
    _loadSavedTweets();
  }

  Future<void> _loadSavedTweets() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/database.json');

    if (file.existsSync()) {
      final jsonString = await file.readAsString();
      final List<Map<String, dynamic>> tweetMaps =
      List<Map<String, dynamic>>.from(json.decode(jsonString));
      setState(() {
        _savedTweets = tweetMaps.map((json) => Tweet.fromJson(json)).toList();
      });
    }
  }


  TextEditingController _tweetController = TextEditingController();
  TextEditingController _imageController = TextEditingController();

  @override
  void dispose() {
    _tweetController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  Future<void> _saveTweetData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/database.json');
      List<Map<String, dynamic>> tweets = [];

      if (file.existsSync()) {
        final jsonString = await file.readAsString();
        tweets = List<Map<String, dynamic>>.from(json.decode(jsonString));
      }

      Tweet newTweet = Tweet(
        text: _tweetController.text,
        avatarPictureUri: widget.avatarPictureUri ?? '',
        userName: widget.userName ?? '',
        userUniqueName: widget.userUniqueName ?? '',
        likeCount: 0,
        viewCount: 0,
        retweetsCount: 0,
        quotesCount: 0,
        bookmarksCount: 0,
        image: _image?.path ?? '',
        twitDate: _selectedDate ?? DateTime.now(),
      );

      tweets.add(newTweet.toJson());
      await file.writeAsString(json.encode(tweets));
      print('Kayıt başarılı!');
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  void _onTweetButtonPressed() async {
    await _saveTweetData();

    final newTweet = Tweet(
      text: _tweetController.text,
      avatarPictureUri: widget.avatarPictureUri ?? '',
      userName: widget.userName ?? '',
      userUniqueName: widget.userUniqueName ?? '',
      likeCount: 0,
      viewCount: 0,
      retweetsCount: 0,
      quotesCount: 0,
      bookmarksCount: 0,
      image: _image?.path ?? '',
      twitDate: _selectedDate ?? DateTime.now(),
    );

    Navigator.pop(context, newTweet);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              onPressed: _onTweetButtonPressed,
              child: const Text('Post'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: _tweetController,
              maxLines: 10,
              decoration: const InputDecoration(
                hintText: 'What is happening?!',
              ),
            ),
            _image != null
                ? Container(
              width: 75,
              height: 75,
              alignment: Alignment.centerLeft,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: _image != null
                    ? Image.file(
                  _image!,
                )
                    : Container(),
              ),
            )
                : Container(),
            Padding(
              padding: const EdgeInsets.only(right: 100, top: 15),
              child: ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Medya'),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
