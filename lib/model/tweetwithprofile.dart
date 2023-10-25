
class TweetWithProfile {
  int id;
  String message;
  String? imageUrl;
  int userId;
  String? avatarPhotoUrl;
  String fullname;
  String username;
  String createdAt;
  int? parentTweetId;


  TweetWithProfile(
      this.id,
      this.message,
      this.imageUrl,
      this.userId,
      this.avatarPhotoUrl,
      this.fullname,
      this.username,
      this.createdAt,
      this.parentTweetId
      );

  factory TweetWithProfile.fromJson(dynamic json) {
    return TweetWithProfile(
      json['id'] as int,
      json['message'] as String,
      json['imageUrl'] as String?,
      json['userId'] as int,
      json['avatarPhotoUrl'] as String?,
      json['fullname'] as String,
      json['username'] as String,
      json['createdAt'] as String,
        json['parentTweetId'] == null ? null : json['parentTweetId'] as int

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'imageUrl': imageUrl,
      'userId':userId,
      'avatarPhotoUrl':avatarPhotoUrl,
      'fullname':fullname,
      'username':username,
      'createdAt': createdAt,
      'parentTweetId':parentTweetId

    };
  }
}

