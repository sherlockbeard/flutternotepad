import 'package:flutter/material.dart';
import 'package:flutternotepad/appbar/Theme.dart' as prefix0;
import 'dart:async';
import 'package:flutternotepad/model/Note.dart';
import 'package:flutternotepad/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

//my files
import 'package:flutternotepad/notes/notedetails.dart';
import 'package:flutternotepad/appbar/Theme.dart';
import 'package:flutternotepad/appbar/value.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  var count = 0;
  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: <Widget>[
          PopupMenuButton<String>(
              onSelected: choice,
              itemBuilder: (BuildContext context) {
                return value.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              })
        ],
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigate(
              Note(
                '',
                '',
              ),
              'Add Note');
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int pos) {
        return Card(
          color: Colors.white,
          elevation: 3.0,
          child: ListTile(
            title: Text(this.noteList[pos].title, style: titleStyle),
            subtitle: Text(this.noteList[pos].date),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                _deletenotes(context, noteList[pos]);
              },
            ),
            onTap: () {
              debugPrint("List item clicked");
              navigate(this.noteList[pos], 'Edit Note');
            },
          ),
        );
      },
    );
  }

  void _deletenotes(context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
    }
  }

  void _showSnackBar(context, String message) {
    final snackbar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackbar);
    updateListView();
  }

  void navigate(Note note, String t) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetails(note, t);
    }));
    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  void choice(String choice) {
    switch (choice) {
      case "Theme":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => prefix0.Themeapp()));
    }
  }
}
