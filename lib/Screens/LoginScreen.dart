import 'dart:convert';

import 'package:demo_app/Screens/Profile.dart';
import 'package:demo_app/api/user-api.dart';
import 'package:demo_app/model/UserModel.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.supervisor_account,
                    size: 80,
                    color: Color(0xff0D698B),
                  ),
                  Text(
                    "Flutter Demo app",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 30, bottom: 10, left: 20),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: emailController,
                cursorColor: Colors.black,
                decoration: InputDecoration.collapsed(hintText: 'Email ...'),
              ),
            ),
            Container(
              height: 50,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: passwordController,
                cursorColor: Colors.black,
                decoration:
                    InputDecoration.collapsed(hintText: 'Mot de passe ...'),
              ),
            ),
            InkWell(
              onTap: () async {
                http.Response res =
                    await login(emailController.text, passwordController.text);
                if (res.body.contains("email not found")) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(
                      'Email not found',
                      style: TextStyle(color: Colors.red),
                    ),
                  ));
                }else
                if (res.body.contains("Incorrrect password")) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(
                      'Incorrect password',
                      style: TextStyle(color: Colors.red),
                    ),
                  ));
                }else
                  if(res.statusCode==200)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text(
                          'logged in with sucess',
                          style: TextStyle(color: Colors.green),
                        ),
                      ));
                   User user=User.fromJson(jsonDecode(res.body));
                  // print(user.firstName);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(user),
                          ));
                    }

              },
              child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ));
                  },
                  child: Text(
                    "create new user",
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
