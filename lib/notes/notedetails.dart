import 'package:flutter/material.dart';
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
  var _formKey = GlobalKey<FormState>();
  DatabaseHelper helper = DatabaseHelper();
  String appbar;
  Note note;

  NoteDetailsState(this.note, this.appbar);
  final titleController = new TextEditingController();
  final descriptionController =new TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
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
        body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: TextFormField(
                      controller: titleController,
                      style: textStyle,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Enter something plz";
                        }
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
                      maxLines: 10,
                      onChanged: (val) {
                        debugPrint('Text cahnged');
                        updateDes();
                      },
                      decoration: InputDecoration(
                          labelText: 'Description',
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
                                if (_formKey.currentState.validate()) {
                                  debugPrint("Save button clicked");
                                  _save();
                                  updateTitle();
                                  updateDes();
                                }
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
            )));
  }

  void moveback() {
    Navigator.pop(context, true);
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDes() {
    note.description = descriptionController.text;
    updateTitle();
  }

  void _save() async {
    moveback();
    int result;
    note.date = DateFormat.yMMMd().format(DateTime.now());
    if (note.id != null) {
      result = await helper.updateNote(note);
    } else {
      result = await helper.insertNote(note);
    }
    if (result != 0) {
      _showAlert('Status', 'Note Saved Sucessfully');
    } else {
      _showAlert('Status', 'Problem Saving it');
    }
  }

  void _delete() async {
    moveback();
    if (note.id == null) {
      _showAlert('Status', 'No Note To Delete');
      return;
    }
    int result = await helper.deleteNote(note.id);
    if (result != 0) {
      _showAlert('Status', 'Note Deleted Successfully');
    } else {
      _showAlert('Status', 'Error Occured while deleting it');
    }
  }

  void _showAlert(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = note.title;
    descriptionController.text = note.description;
  }
}
