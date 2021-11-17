// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  News({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  var status;
  int totalResults;
  List<Article> articles;

  factory News.fromJson(Map<String, dynamic> json) => News(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
  static Future<List<News>> fetchData() async{
    String url = "https://newsapi.org/v2/everything?q=apple&apiKey=536d92e81fa34fd7a798032b5ab7b069";
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    List<News> ls = [];
    if(response.statusCode == 200){
      print('Tai du lieu thanh cong');
      var result = response.body;
      News s = newsFromJson(result);
      ls.add(newsFromJson(result));
      return ls;
    }
    else{
      print('Tai du lieu that bai');
      throw Exception("Loi lay du lieu. Chi tiết: ${response.statusCode}");
    }
  }
}

class Article {
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Source source;
  var author;
  var title;
  var description;
  var url;
  var urlToImage;
  DateTime publishedAt;
  var content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    source: Source.fromJson(json["source"]),
    author: json["author"] == null ? null : json["author"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    urlToImage: json["urlToImage"] == null ? null : json["urlToImage"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "source": source.toJson(),
    "author": author == null ? null : author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage == null ? null : urlToImage,
    "publishedAt": publishedAt.toIso8601String(),
    "content": content,
  };
}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  var id;
  var name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"] == null ? null : json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name,
  };
}
