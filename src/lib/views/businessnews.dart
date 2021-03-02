import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:src/shared/custom_style.dart';

Future<NewsData> fetchNewsData() async {
  final response = await http.get(
      'http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=1fbee980d10644bca6e4c3243034c10a');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return NewsData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load NewsData');
  }
}

class NewsData {
  final String status;
  final int totalResults;
  final List<dynamic> articles;
  const NewsData({this.status, this.totalResults, this.articles});
  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
        status: json['status'],
        totalResults: json['totalResults'],
        articles:
            json['articles'].map((value) => new News.fromJson(value)).toList());
  }
}

class News {
  final String author;
  final String title;
  final String description;
  final String urlToImage;
  final String publishedAt;
  final String content;

  News(
      {this.author,
      this.title,
      this.description,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      author: json['author'],
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}

class BussNews extends StatefulWidget {
  // This widget is the MD New page of your application.
  BussNews({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BussNewsState createState() => _BussNewsState();
}

class _BussNewsState extends State<BussNews> {
  Future<NewsData> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = fetchNewsData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: FutureBuilder<NewsData>(
            future: futureNews,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // return Text(snapshot.data.articles[0].title);
                return Column(children: [
                  SizedBox(
                      height: 1000.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        // itemExtent: 125,
                        itemCount: snapshot.data.articles.length,
                        itemBuilder: (context, index) => _buildListItem(
                            context, snapshot.data.articles[index]),
                      ))
                ]);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(context, News item) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ListTile(
          isThreeLine: true,
          // leading: Image.asset(item.urlToImage, width: 80, height: 80),
          title: Text((item.title == null) ? "" : item.title, style: cBodyText),
          subtitle: Column(
            children: <Widget>[
              Text(
                (item.description == null) ? "" : item.description,
              ),
              // Image.network(item.urlToImage, width: 180, height: 180),
              Text((item.publishedAt == null) ? "" : item.publishedAt,
                  style: cBodyText),
              Image.network((item.urlToImage == null) ? "" : item.urlToImage),
              Text((item.author == null) ? "" : item.author, style: cBodyText),
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
