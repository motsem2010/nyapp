import 'package:flutter_test/flutter_test.dart';
import 'package:jo/main.dart';
import 'package:jo/model/article.dart';
import 'package:jo/shared/utils.dart';
void main(){


  test('test 1 day articles',()async{
    List<Article>itemsData = await HttpServ.obtainJson('1');
    expect(itemsData.length, 19);

  });
  test('test 7 day articles',()async{
    List<Article>itemsData = await HttpServ.obtainJson('7');
    expect(itemsData.length, 19);

  });
  test('test 30 day articles',()async{
    List<Article>itemsData = await HttpServ.obtainJson('30');
    expect(itemsData.length, 19);

  });
}