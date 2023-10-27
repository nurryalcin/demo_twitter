import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twitter/model/message.dart';
import 'package:twitter/model/user.dart';

class MessageService {
  final String baseUrl = 'http://192.168.1.70:5169';

  Future<Message> sendMessage(String message, int userId, int senderId) async {
    var data = {"messages": message, "userId": userId, "senderId": senderId};
    final response = await http.post(
      Uri.parse('$baseUrl/message/sendmessage'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return Message.fromJson(responseData);
    } else {
      throw Exception('Mesaj gönderme başarısız: ${response.statusCode}');
    }
  }

  Future<List<Message>> getMessages(int userId, int senderId) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/message/getmessage?userId=$userId &senderId=$senderId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<Message> messages = [];
        for (var data in responseData) {
          messages.add(Message.fromJson(data));
        }
        return messages;
      } else {
        throw Exception(
            'Mesajları alırken bir hata oluştu: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Mesajları alırken bir hata oluştu: $e');
    }
  }

  Future<List<User>> getSenderId(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/getsenderıd?userId=$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      List<User> senders = [];
      for (var data in responseData) {
        senders.add(User.fromJson(data));
      }
      return senders;
    } else {
      throw Exception('Kullanıcıları alırken bir hata oluştu: ${response.statusCode}');
    }
  }

}
