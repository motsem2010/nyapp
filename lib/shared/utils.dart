import 'dart:convert';
import 'package:http/http.dart';
import 'package:jo/model/article.dart';
import 'package:jo/shared/constant.dart';

class HttpServ {
  static String get_str_btwn(String str_to_parse, String suff, String prefx) {
    int start_indx = -1, last_indx = -1;
    start_indx = str_to_parse.indexOf(suff);
    last_indx = str_to_parse.indexOf(prefx);
    if (start_indx != -1 && last_indx != -1) {
      return str_to_parse.substring(
          start_indx + suff.length + 1, last_indx + 3);
    } else {
      return '';
    }
  }
static Future<List<Article>> obtainJson(String postsView) async{
  List<Article> list=[];
  String postsURL =
      'https://api.nytimes.com/svc/mostpopular/v2/viewed/${postsView}.json?api-key=avBP67kGmNg9JL1afHZcvt6xrTWcJJYj';
  final response = await get(postsURL); //1
  String responseBody = response.body; //2
  //String bodyStr = get_str_btwn(responseBody, '"results":', '}]}');
  String modifResp=responseBody.substring(1,responseBody.length-2);
  List<String>parsedJson=modifResp.split('"eta_id":0},');
  int _firstIndx=parsedJson[0].indexOf('{',20);
  if(_firstIndx!=-1){
    parsedJson[0]=parsedJson[0].substring(_firstIndx);
  }else{
    parsedJson.removeAt(0);

  }
  //print('length=${parsedJson.length.toString()}'+modifResp.toString().substring(modifResp.length-200));
  //print(parsedJson.last.substring(parsedJson.last.length-200));
  for(int i =0;i<parsedJson.length-1;i++){
    parsedJson[i]=parsedJson[i]+'"eta_id":0}';

        Map<String,dynamic> f = json.decode(parsedJson[i]);
        if (f.isNotEmpty) {
          list.add(Article.fromJson(f));
        print(parsedJson[i].substring(0,100));
      }

  }
  //print('list of length${list.length.toString()},the length of Json=${parsedJson.length.toString()}call http succeffully');
  return list; //6
}


}

class Utilities { //get data from constant.dart locally
//  List<Article> itemsData = [];

  static List<Article> getArticlessData(List<dynamic> data) {
    List<dynamic> responseList = data;
    List<Article> listItems = [];

    responseList.forEach((post) {
      Article _artObj = new Article(
          id:  post["id"],
          asset_id:post["asset_id"],
          uri: post["uri"],
          url:post["url"],
          source:post["source"],
          published_date:post["published_date"],
          updated:post["updated"],
          section:post["section"],
          subsection:post["subsection"],
          nytdsection:post["nytdsection"],
          adx_keywords:post["adx_keywords"],
          column:post["column"],
          byline:post["byline"],
          type:post["type"],
          title:post["title"],
          abstract:post["abstract"]
          //, [], [], [], []
          //post["des_facet"] ,post["org_facet"] ,post["per_facet"] ,post["geo_facet"]

          );
      if (_artObj != null) {
        listItems.add(_artObj);
      }
    });

    return listItems;
  }
}
