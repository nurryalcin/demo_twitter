class TweetWithParent {
  final int repliedTweetId;
  final String repliedTweetMessage;
  final String? repliedTweetImageUrl;
  final int repliedTweetUserId;
  final String repliedTweetCreatedAt;
  final int repliedTweetParentTweetId;
  final String repliedUsername;
  final String repliedFullname;
  final int parentTweetId;
  final String parentTweetMessage;
  final String? parentTweetImageUrl;
  final int parentTweetUserId;
  final String parentTweetCreatedAt;
  final String parentUsername;
  final String parentFullname;

  TweetWithParent({
    required this.repliedTweetId,
    required this.repliedTweetMessage,
    required this.repliedTweetImageUrl,
    required this.repliedTweetUserId,
    required this.repliedTweetCreatedAt,
    required this.repliedTweetParentTweetId,
    required this.repliedUsername,
    required this.repliedFullname,
    required this.parentTweetId,
    required this.parentTweetMessage,
    required this.parentTweetImageUrl,
    required this.parentTweetUserId,
    required this.parentTweetCreatedAt,
    required this.parentUsername,
    required this.parentFullname,
  });

  factory TweetWithParent.fromJson(Map<String, dynamic> json) {
    return TweetWithParent(
      repliedTweetId: json['repliedTweetId'] as int,
      repliedTweetMessage: json['repliedTweetMessage'] as String,
      repliedTweetImageUrl: json['repliedTweetImageUrl'] as String?,
      repliedTweetUserId: json['repliedTweetUserId'] as int,
      repliedTweetCreatedAt: json['repliedTweetCreatedAt'] as String,
      repliedTweetParentTweetId: json['repliedTweetParentTweetId'] as int,
      repliedUsername: json['repliedTweetUsername'] as String,
      repliedFullname: json['repliedTweetFullName'] as String,
      parentTweetId: json['parentTweetId'] as int,
      parentTweetMessage: json['parentTweetMessage'] as String,
      parentTweetImageUrl: json['parentTweetImageUrl'] as String?,
      parentTweetUserId: json['parentTweetUserId'] as int,
      parentTweetCreatedAt: json['parentTweetCreatedAt'] as String,
      parentUsername: json['parentTweetUsername'] as String,
      parentFullname: json['parentTweetFullName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'repliedTweetId': repliedTweetId,
      'repliedTweetMessage': repliedTweetMessage,
      'repliedTweetImageUrl': repliedTweetImageUrl,
      'repliedTweetUserId': repliedTweetUserId,
      'repliedTweetCreatedAt': repliedTweetCreatedAt,
      'repliedTweetParentTweetId': repliedTweetParentTweetId,
      'repliedFullname':repliedFullname,
      'repliedUsername':repliedUsername,
      'parentTweetId': parentTweetId,
      'parentTweetMessage': parentTweetMessage,
      'parentTweetImageUrl': parentTweetImageUrl,
      'parentTweetUserId': parentTweetUserId,
      'parentTweetCreatedAt': parentTweetCreatedAt,
      'parentFullname':parentFullname,
      'parentUsername':parentUsername,


    };
  }
}
