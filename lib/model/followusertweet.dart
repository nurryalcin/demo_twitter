
class FollowUserTweet {
  int id;
  int userId;
  int followedUserId;
  String message;
  String? imageUrl;
  String? avatarPhotoUrl;
  String fullname;
  String username;
  String createdAt;


  FollowUserTweet(
      this.id,
      this.userId,
      this.followedUserId,
      this.message,
      this.imageUrl,
      this.avatarPhotoUrl,
      this.fullname,
      this.username,
      this.createdAt,
      );

  factory FollowUserTweet.fromJson(dynamic json) {
    return FollowUserTweet(
      json['id'] as int,
      json['userId'] as int,
      json['followedUserId'] as int,
      json['message'] as String,
      json['imageUrl'] as String?,
      json['avatarPhotoUrl'] as String?,
      json['fullname'] as String,
      json['username'] as String,
      json['createdAt'] as String,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId':userId,
       'followedUserId':followedUserId,
      'message': message,
      'imageUrl': imageUrl,
      'avatarPhotoUrl':avatarPhotoUrl,
      'fullname':fullname,
      'username':username,
      'createdAt': createdAt,

    };
  }
}

