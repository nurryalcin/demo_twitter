import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:twitter/ui/screens/widgets/tweetwidget.dart';
import 'addtweet.dart';


class ListWidget extends StatefulWidget{
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
        leading: profileImage != null
            ? CircleAvatar(
          backgroundImage: FileImage(File(profileImage!)),
        )
            : null,
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
