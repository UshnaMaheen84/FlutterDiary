import 'package:diary/DatabaseHelper.dart';
import 'package:diary/models/NotesModel.dart';
import 'package:diary/screens/write_diary.dart';
import 'package:diary/screens/write_note.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(Notes());
}

class Notes extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const routeName = 'edit-entry';

  MyHomePage({Key key}) : super(key: key);

  NotesLists createState() => NotesLists();
}

class NotesLists extends State<MyHomePage> {
  NotesModel _notesModel = NotesModel();
  List<NotesModel> notesList = [];
  DatabaseHelper _dbHelper;

  @override
  void initState() {
    super.initState();
    setState(() {
      _dbHelper = DatabaseHelper.instance;
    });
    _refreshList();    _dbHelper = DatabaseHelper.instance;


  }
  void _refreshList() async {
    List<NotesModel> x = await _dbHelper.fetchNote();
    setState(() {
      notesList = x;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text("NOTES"),
        ),
        body: Container(
          color: Color(0xffffe2bb),
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ""+notesList.length.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: notesList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Container(
                                padding: const EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.pink),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            ""+notesList[index].note,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),

                                        ///For Space
                                        SizedBox(
                                          width: 4,
                                        ),
                                      ],
                                    ),

                                    ///For Space
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "18 NOV 2019",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Write_diary();
                                }));
                              },
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            height: 16,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Write_note();
            }));
          },
          child: Icon(Icons.edit),
        ),
      ),
    );
  }

}
