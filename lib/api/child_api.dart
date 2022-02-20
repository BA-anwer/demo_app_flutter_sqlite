import 'dart:convert';

import 'package:demo_app/model/child.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

Future<List<Child>> getAllChildren(int idParent)async{
  List<Child> children=[];

    var url=serverUrl+"/allChildsByParent/${idParent}";
  var response=await http.get(Uri.parse(url));
  print(response.statusCode);
  print(json.decode(response.body).toString());
  if(response.statusCode==200)
  {
    var list= jsonDecode(response.body) as List;
    children=list.map((i) => new Child.fromJson(i)).toList();

  }
  return children;
}

Future<Child> createChild(Child c,int idParent) async {
  var url = Uri.parse(serverUrl+'/createChildWithParent/${idParent}');
  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(c.toJson()));
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  return c;
}

