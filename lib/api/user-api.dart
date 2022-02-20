import 'dart:convert';
import 'package:demo_app/model/UserModel.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';






Future<List<User>> getUsers()async{
  List<User> users=[];

  var url=serverUrl+"/allUsers";
  var response=await http.get(Uri.parse(url));
  print(response.statusCode);
  print(json.decode(response.body).toString());
 if(response.statusCode==200)
   {
   var list= jsonDecode(response.body) as List;
     users=list.map((i) => new User.fromJson(i)).toList();

   }
  return users;
}

Future<http.Response> deleteUserService(int id) async {
  var url = serverUrl+"/deleteUser/${id}";
  var response = await http.delete(Uri.parse(url));
  print(response.statusCode);
  print(json.decode(response.body).toString());
  return response;
}


Future<http.Response> login(String email,String password) async {
  var url = Uri.parse(serverUrl+'/login');
  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "email": email,
        "password": password
      }));
 // print("\n ********** "+response.body);
  return response;
}

Future<User> add_user(User u) async {
  var url = Uri.parse(serverUrl+'/createUser');
  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(u.toJson()));
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  return u;
}

Future<User> update_user(User u,int id) async {
  var url = Uri.parse(serverUrl+'/updateUser/${id}');
  var response = await http.put(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(u.toJson()));
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  return u;
}