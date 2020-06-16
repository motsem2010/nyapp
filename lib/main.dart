import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jo/model/article.dart';
import 'package:jo/shared/utils.dart';
import 'package:jo/view/article_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NY Times Most Popular',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'NY Times Most Popular'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> itemsData = [];

  bool _isCallingJson = false;

  Future<int> _getData(String val) async {
    int res=-1;
    setState(() {
      _isCallingJson = true;
    });
    itemsData = await HttpServ.obtainJson(val);
    res=itemsData.length;
    setState(() {
      _isCallingJson = false;
    });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    void _openArticleDetails(BuildContext ctx,Article itemsData) {
      print(itemsData.id.toString());
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ArticleDetails(itemsData);
          }));

    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear, color: Colors.white),
            tooltip: 'Clear Articles',
            onPressed: () {
              setState(() {
                itemsData.clear();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: itemsData.length == 0
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('press FAB to Get Data'),
                SizedBox(
                  height: 25,
                ),
                Visibility(
                    visible: _isCallingJson,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.orange,
                    ))
              ],
            ))
          : Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: ListView.builder(
                  itemCount: itemsData.length,
                  itemBuilder: (ctx, ind) {
                    return Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withAlpha(100),
                                  blurRadius: 10.0),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.note,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      itemsData[ind].title,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      itemsData[ind].byline,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          itemsData[ind].source,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        FlatButton.icon(
                                          icon: Icon(Icons.date_range),
                                          label: Text(
                                            itemsData[ind].published_date,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  print('calling item number ${ind.toString()} tit:${itemsData[ind].title}');
                                 _openArticleDetails(ctx,itemsData[ind]);
                                 // print(itemsData[ind].toString());
                                },
                              )
                            ],
                          ),
                        ));
                  }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _getData('7');
        },
        tooltip: 'Load Data',
        child: Icon(Icons.file_download),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

  }


}
