
import 'package:demo_app/Screens/ChildScreen.dart';
import 'package:demo_app/model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../api/child_api.dart';


class ProfileScreen extends StatefulWidget {
  User user ;
  ProfileScreen(this.user);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.account_circle),text: "User",),
              Tab(icon: Icon(Icons.child_care),text: "Children",),

            ],
          ),
          title: Text("Profile"),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child:Text("First name : "+widget.user.firstName,style: TextStyle(fontSize: 20),) ,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child:Text("Last name : "+widget.user.lastName,style: TextStyle(fontSize: 20),) ,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child:Text("Email : "+widget.user.email,style: TextStyle(fontSize: 20),) ,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child:Text("Numéro : "+widget.user.numTel,style: TextStyle(fontSize: 20),) ,
                    ),
                  ),



                ],
              ),
            ),
            FutureBuilder(
              future: getAllChildren(widget.user.idUser),
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
                                      Text(snapshot.data[i].age.toString()),
                                      Text(snapshot.data[i].dateNais.toString()),
                                    ],
                                  ),
                                ),
                                leading: Icon(
                                  Icons.child_care,
                                  color: Color(0xFF050533),
                                  size: 40,
                                ),
                              )),
                        );
                      });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
