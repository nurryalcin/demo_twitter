
class Tweet {
  int tweetId;
  String? message;
  String? imageUrl;
  int userId;
  String createdAt;
  int? parentTweetId;


  Tweet(
      this.tweetId,
      this.message,
      this.imageUrl,
      this.userId,
      this.createdAt,
      this.parentTweetId
      );

  factory Tweet.fromJson(dynamic json) {
    return Tweet(
      json['tweetId'] as int,
      json['message'] as String?,
      json['imageUrl'] as String?,
      json['userId'] as int,
      json['createdAt'] as String,
      json['parentTweetId'] as int?

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': tweetId,
      'fullname': message,
      'avatarPhotoUrl': imageUrl,
       'userId':userId,
      'createdAt': createdAt,
      'parentTweetId':parentTweetId

    };
  }
}

