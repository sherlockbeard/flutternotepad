import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutternotepad/model/Note.dart';
import 'package:flutternotepad/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';


//my files
import 'package:flutternotepad/notes/noteslist.dart';

class NoteDetails extends StatefulWidget {
  String appbar;
  Note note;
  NoteDetails(this.note,this.appbar);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteDetailsState(note,appbar);
  }
}

class NoteDetailsState extends State<NoteDetails> {
  String appbar;
  Note note;
  NoteDetailsState(this.note,this.appbar);

  static var _priporities = ['Height', 'Low'];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(appbar),
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
            moveback();
          },)
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: DropdownButton(
                  items: _priporities.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  style: textStyle,
                  value: _priporities[1],
                  onChanged: (val) {
                    setState(() {
                      debugPrint("User value $val");
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: titleController,
                  style: textStyle,
                  onChanged: (val) {
                    debugPrint('Text cahnged');
                  },
                  decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: descriptionController,
                  style: textStyle,
                  onChanged: (val) {
                    debugPrint('Text cahnged');
                  },
                  decoration: InputDecoration(
                      labelText: 'description',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Save button clicked");
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Delete',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Delete button clicked");
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
  void moveback(){
    Navigator.pop(context);
  }
}
