import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Data {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Data(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUrl});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        albumId: json['albumId'],
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl']);
  }
}

Future<Data> feathdata() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  if (response.statusCode == 200) {
    return Data.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
