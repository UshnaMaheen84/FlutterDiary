import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(Write_diary());
}
class Write_diary extends StatelessWidget {
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
  DateTime date;
  TextEditingController _textEditingController = TextEditingController();


  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date ?? now,
        firstDate: now,
        lastDate: DateTime(2101));
    if (picked != null && picked != date) {
      print('hello $picked');
      setState(() {
        date = picked;

        _textEditingController.text = new DateFormat('dd-MMMM-yyyy').format(date);

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Write Diary"),
      ),
      body: Center(
        child: Container(
          //         color: Color(0xffffe2bb),
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Column(

            children: <Widget>[
              SizedBox(height: 45),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),

                child: TextFormField(
                  controller: _textEditingController,

                  onTap: () async {
                    // Below line stops keyboard from appearing
                    FocusScope.of(context).requestFocus(new FocusNode());
                    // Show Date Picker Here
                    await _selectDate(context);
                  },

                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 1,
                  cursorColor: Color(0xFF3C4858),
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Date',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 3,
                  cursorColor: Color(0xFF3C4858),
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'SUBJECT',
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  cursorColor: Color(0xFF3C4858),
                  decoration: InputDecoration.collapsed(
                      hintText:
                      'Tell me about your day and thoughts !'),
                ),

              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(Icons.done),
        onPressed: () {

        },
      ),
    );
  }

}
