

import 'package:demo_app/api/child_api.dart';
import 'package:demo_app/model/child.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChildScreen extends StatefulWidget {
  int idParent ;
  ChildScreen(this.idParent);
  @override
  _ChildScreenState createState() => _ChildScreenState();
}

class _ChildScreenState extends State<ChildScreen> {

  DateTime date_nais=null;
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();




  Future<void> addChild(BuildContext context ) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.black,
              child: Container(
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
                        "Ajouter Enfant",
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
                        keyboardType: TextInputType.number,
                         controller: ageController,
                        cursorColor: Colors.black,
                        decoration:
                        InputDecoration.collapsed(hintText: 'Age ...'),
                      ),
                    ),

                    InkWell(
                      onTap: (){
                      DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2010, 3, 5),
                            maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                              print('change $date');
                            }, onConfirm: (date) {
                            setState(() {
                              date_nais=date;
                            });
                            Navigator.pop(context);
                            addChild(context);

                              print('confirm $date');
                            }, currentTime:this.date_nais==null? DateTime.now():date_nais, locale: LocaleType.fr);
                      },
                      child:  Container(
                          height: 50,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:Text(date_nais.toString())
                      ),
                    ),

                    InkWell(
                      onTap: ()async {
                        Child child = Child();
                        child.firstName=firstNameController.text;
                        child.lastName=lastNameController.text;
                        child.dateNais=date_nais;
                        await createChild(child, widget.idParent);
                        firstNameController.clear();
                        lastNameController.clear();
                        ageController.clear() ;
                        Navigator.of(context).pop();
                        setState(() {

                        });
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
            ),


        );
        }

        );


  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    date_nais=DateTime.now();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F1E8),
      appBar: AppBar(
        title: Text("Listes des enfants "),
        backgroundColor: Color(0xff0D698B),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(

                icon: Icon(Icons.add),
                onPressed: (){
                  addChild(context);
                },
              ))
        ],
      ),
      body:  FutureBuilder(
        future: getAllChildren(widget.idParent),
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
    );
  }
}
