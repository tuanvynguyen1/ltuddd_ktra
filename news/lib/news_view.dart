import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news/web_view.dart';

import 'news.dart';

class MyAppNews extends StatelessWidget {
  const MyAppNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewsApp()
    );
  }
}

class NewsApp extends StatefulWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  _NewsAppState createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  late Future<List<News>> ds;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ds = News.fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NewsApp", style: TextStyle(color: Colors.black) ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: false,
      body: FutureBuilder(
        future: ds,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var news = snapshot.data;
            var articles = news[0].articles;
            return ListView.builder(
              itemCount: articles!.length,
              itemBuilder: (BuildContext context, int index) {
                var n = articles[index];
                return Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: ListTile(
                      leading: Image.network(
                        n.urlToImage == null || n.urlToImage == ""? "https://st.depositphotos.com/1987177/3470/v/950/depositphotos_34700099-stock-illustration-no-photo-available-or-missing.jpg":n.urlToImage,
                        width: 40,
                      ),
                      title: Text(n.title),
                      subtitle: Text(n.description),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => web(
                          url: n.url,
                          title: n.title,
                        )));
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

