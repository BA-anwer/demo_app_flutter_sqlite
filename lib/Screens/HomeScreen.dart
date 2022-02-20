import 'dart:async';
import 'package:demo_app/Screens/ChildScreen.dart';
import 'package:demo_app/model/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../api/user-api.dart' as api;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User> users = [];
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telController = TextEditingController();

  @override
  initState() {
    fetch_Users_List();
    super.initState();
  }



  void _onButtonPressedAddUser({User user}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.black,
              child: Container(
               // height: 900,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 22, top: 25, bottom: 20),
                      child: Text(
                        "Ajouter utilisateur",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                        controller: lastNameController,
                        cursorColor: Colors.black,
                        decoration:
                            InputDecoration.collapsed(hintText: 'Nom ...'),
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
                        controller: firstNameController,
                        cursorColor: Colors.black,
                        decoration:
                            InputDecoration.collapsed(hintText: 'Prènom ...'),
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
                        decoration:
                            InputDecoration.collapsed(hintText: 'Email ...'),
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
                        controller: telController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Numéro téléphone ...'),
                      ),
                    ),
                    InkWell(
                      onTap: ()async {
                        Navigator.of(context).pop();
                        User user = User(
                            lastNameController.text,
                            firstNameController.text,
                            emailController.text,
                            telController.text,'');
                        await api.add_user(user);
                        lastNameController.clear();
                        firstNameController.clear();
                        emailController.clear();
                        telController.clear();
                        setState(() {});
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
                              'Valider',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> fetch_Users_List() async {
    print("fetching users");
    List<User> u = await api.getUsers();
    setState(() {
      users = u;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F1E8),
      appBar: AppBar(
        title: Text("Listes des utilisateurs"),
        backgroundColor: Color(0xff0D698B),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.wifi))
        ],
      ),
      body:  FutureBuilder(
        future: api.getUsers(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return Slidable(
                    key: ValueKey(0),
                    startActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          backgroundColor: Color(0xFFE34234),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                          onPressed: (context) async {
                           // await db.deleteUser(user.idUser);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    child: Card(
                        margin: EdgeInsets.only(
                            top: 5, bottom: 5, left: 5, right: 5),
                        child: ListTile(
                          title: Padding(
                            padding: EdgeInsets.only(top: 7),
                            child: Text(
                              snapshot.data[i].firstName + ' ' + snapshot.data[i].lastName,
                              style:
                              TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(bottom: 7),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data[i].email),
                                Text(snapshot.data[i].idUser.toString())
                              ],
                            ),
                          ),
                          leading: Icon(
                            Icons.person,
                            color: Color(0xFF050533),
                            size: 40,
                          ),
                          trailing:InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (context) => ChildScreen(snapshot.data[i].idUser),
                              ));
                            },
                            child:  Icon(
                              Icons.remove_red_eye_sharp,
                              color: Color(0xFF050533),
                              size: 30,
                            ),
                          ),
                        )),
                  );
                });
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()  {
          _onButtonPressedAddUser();
        },
        backgroundColor: Color(0xff0D698B),
        child: Icon(Icons.person_add),
      ),
    );
  }

}
