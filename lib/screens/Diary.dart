import 'package:diary/screens/write_diary.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Diary());
}

class Diary extends StatelessWidget {
  // This widget is the root of your application.
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
          title: Text("DIARY"),
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
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index){
                            return Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.pink
                                  ),
                                  color:  Colors.white
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Subject",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  ///For Space
                                  SizedBox(height: 5),
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
                            );
                          },
                          separatorBuilder: (context, index) => Divider(height: 16, color: Colors.transparent,),
                          itemCount: 13,
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
              return Write_diary();
            }));
          },
          child: Icon(Icons.edit),
        ),
      ),
    );
  }
}
