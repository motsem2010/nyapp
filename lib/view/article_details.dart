
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jo/model/article.dart';
class ArticleDetails extends StatefulWidget {
  Article _article;

  ArticleDetails(this._article);

  @override
  _ArticleDetailsState createState() => _ArticleDetailsState(_article);
}

class _ArticleDetailsState extends State<ArticleDetails> {
  Article _article;

  _ArticleDetailsState(this._article);
Widget _rowsListView(String _label,String _value,int _line){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: <Widget>[
        Container(
width: 100,
            child: Text(_label,overflow: TextOverflow.ellipsis,style:GoogleFonts.aclonica(backgroundColor: Colors.black12),)
        ),
        Expanded(
            child: Text(_value,softWrap: true,style: GoogleFonts.sahitya(color: Colors.black54),))
      ],
    ),
  );

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  backgroundColor: Colors.greenAccent,

),
      body: ListView(
        children: <Widget>[
          //Text('Motasem Al taamneh'),
          SizedBox(height: 30,),
          _rowsListView('Title:',_article.title,3),
          _rowsListView('byLine:',_article.byline,3),
          _rowsListView('id:',_article.id.toString(),3),
          _rowsListView('source:',_article.source,3),
          _rowsListView('published:',_article.published_date,3),
          _rowsListView('updated:',_article.updated,3),

          _rowsListView('section:',_article.section,3),
          _rowsListView('type:',_article.type,3),
          _rowsListView('abstract:',_article.abstract,5),
          _rowsListView('keywords:',_article.adx_keywords,3),
          _rowsListView('des_facet:',_article.des_facet.toString(),3),
          _rowsListView('geo_facet:',_article.geo_facet.toString(),3),


        ],
      ),
    );
  }
}
