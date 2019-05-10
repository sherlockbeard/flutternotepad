import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutternotepad/model/Note.dart';
import 'package:flutternotepad/database/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

//my files
import 'package:flutternotepad/notes/noteslist.dart';

class NoteDetails extends StatefulWidget {
  String appbar;
  Note note;
  NoteDetails(this.note, this.appbar);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteDetailsState(note, appbar);
  }
}

class NoteDetailsState extends State<NoteDetails> {
  DatabaseHelper helper = DatabaseHelper();
  String appbar;
  Note note;

  NoteDetailsState(this.note, this.appbar);

  static var _priporities = ['Height', 'Low'];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    titleController.text = note.title;
    descriptionController.text = note.description;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text(appbar),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                moveback();
              },
            )),
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
                  value: getPriorityAsString(note.priority),
                  onChanged: (val) {
                    setState(() {
                      debugPrint("User value $val");
                      updatePriorityAsInt(val);
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
                    updateTitle();
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
                    updateDes();
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
                            _save();
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
                            _delete();
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

  void moveback() {
    Navigator.pop(context,true);
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  String getPriorityAsString(int val) {
    String priority;
    switch (val) {
      case 1:
        priority = _priporities[0];
        break;
      case 2:
        priority = _priporities[1];
        break;
    }
    return priority;
  }

  void updateTitle(){
    note.title = titleController.text;
  }

  void updateDes(){
    note.description= descriptionController.text;
  }

  void _save() async{
    moveback();
    int result;
    note.date=DateFormat.yMMMd().format(DateTime.now());
    if(note.id!=null){
      result = await helper.updateNote(note);
    }else{
      result = await helper.insertNote(note);
    }
    if(result!=0){
      _showAlert('Status','Note Saved Sucessfully');
    }else{
      _showAlert('Status','Problem Saving it');
    }
  }


  void _delete() async{
    moveback();
    if(note.id==null){
      _showAlert('Status', 'No Note To Delete');
      return;
    }
    int result = await helper.deleteNote(note.id);
    if(result!=0){
      _showAlert('Status', 'Note Deleted Successfully');
    }else{
      _showAlert('Status', 'Error Occured while deleting it');
    }
  }
  void _showAlert(String title,String message){
    AlertDialog alertDialog = AlertDialog(title: Text(title),content: Text(message),);
    showDialog(context: context,builder: (_) => alertDialog);
  }
}
