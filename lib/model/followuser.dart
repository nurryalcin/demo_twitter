class FollowUser {
  int userId;
  int followedUserId;

  FollowUser(
      this.userId,
      this.followedUserId);

  factory FollowUser.fromJson(dynamic json) {
    return FollowUser(
        json['userId'] as int,
        json['followedUserId'] as int

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId' :userId,
      'followedUserId': followedUserId
    };
  }
}