
class User {
  int id;
  String username;
  String fullname;
  String? avatarPhotoUrl;
  String createdAt;
  String email;


  User(
      this.id,
      this.username,
      this.fullname,
      this.avatarPhotoUrl,
      this.createdAt,
      this.email,
      );

  factory User.fromJson(dynamic json) {
    return User(
      json['id'] as int,
      json['username'] as String,
      json['fullname'] as String,
      json['avatarPhotoUrl'] as String?,
      json['createdAt'] as String,
      json['email'] as String,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'fullname': fullname,
      'avatarPhotoUrl': avatarPhotoUrl,
      'createdAt': createdAt,
      'email': email,

    };
  }
}

