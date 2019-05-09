import 'package:flutter/material.dart';

class NoteDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteDetailsState();
  }
}

class NoteDetailsState extends State<NoteDetails> {
  static var _priporities = ['Height', 'Low'];

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Note Detail'),
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
                      final snackBar = SnackBar(
                        content: Text('Yay! A SnackBar!'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change!
                          },
                        ),
                      );

                      // Find the Scaffold in the Widget tree and use it to show a SnackBar!
                      Scaffold.of(context).showSnackBar(snackBar);
                    });
                  },
                ),
              )
            ],
          ),
        ));
  }
}
