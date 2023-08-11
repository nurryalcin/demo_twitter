import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:twitter/ui/screens/widgets/tweetwidget.dart';
import 'addtweet.dart';


class ListWidget extends StatefulWidget{
  const ListWidget({super.key});

  @override
  State<StatefulWidget> createState()=> _ListWidgetState();


}
class _ListWidgetState extends State<ListWidget> {
  List<Tweet> tweets = [];

  String? profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Tweet>>(
          future: fetchTweetsDataFromJson(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Veriler alınamadı: ${snapshot.error}');
            } else {
              List<Tweet> tweetList = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tweetList.length,
                itemBuilder: (context, index) {
                  Tweet tweet = tweetList[index];
                  return TweetWidget(tweet: tweet);
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTweet()),
          ).then((newTweet) {
            if (newTweet != null && newTweet is Tweet) {
              setState(() {
                tweets.add(newTweet);
              });
            }
          });
        },
        child: const Icon(Icons.post_add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

Future<Tweet?> fetchUserDataFromJson() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/login.json';
    final file = File(filePath);

    if (!file.existsSync()) {
      print("Dosya bulunamadı.");
      return null;
    }

    String jsonString = await file.readAsString();
    Map<String, dynamic> userData = json.decode(jsonString);

    String username = userData['userName'];
    String useruniquename = userData['userUniqueName'];
    String avatarpictureuri = userData['avatarPictureUri'];

    Tweet userTweet = Tweet(
      text: "",
      avatarPictureUri: avatarpictureuri,
      userName: username,
      userUniqueName: useruniquename,
      twitDate: DateTime.now(),
      likeCount: 0,
      viewCount: 0,
      retweetsCount: 0,
      quotesCount: 0,
      bookmarksCount: 0,
    );

    return userTweet;
  } catch (e) {
    print("Veri çekme hatası: $e");
    return null;
  }
}



Future<List<Tweet>> fetchTweetsDataFromJson() async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/database.json');

  if (!file.existsSync()) {

    return [];

  }

  String jsonString = await file.readAsString();
  List<Map<String, dynamic>> jsonData =
  List<Map<String, dynamic>>.from(json.decode(jsonString));
  List<Tweet> tweets = jsonData.map((data) => Tweet.fromJson(data)).toList();
  return tweets;
}