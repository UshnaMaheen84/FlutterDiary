import 'package:diary/models/NotesModel.dart';
import 'package:flutter/material.dart';

import '../DatabaseHelper.dart';

void main() {
  runApp(Write_note());
}

class Write_note extends StatelessWidget {
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

  _EditEntryState createState() => _EditEntryState();
}

class _EditEntryState extends State<MyHomePage> {

  NotesModel _notesModel = NotesModel();
  List<NotesModel> notesList = [];
  DatabaseHelper _dbHelper;
  String setValue ="" ;
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Write Note"),
      ),
      body: Center(
        child: Container(
          // color: Color(0xffffe2bb),
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 15),
              Expanded(
                child: TextFormField(
                  controller: myController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  cursorColor: Color(0xFF3C4858),
                  decoration: InputDecoration.collapsed(
                      hintText: 'write your note here.'
                  ),
                ),
              ),
              Text("new "+myController.text)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(Icons.done),
        onPressed: () async {
          _notesModel.note = myController.text;
          _notesModel.id = null;
          await _dbHelper.insertNote(_notesModel);
        },
      ),
    );
  }
}
