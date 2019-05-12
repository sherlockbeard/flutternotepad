import 'package:flutter/material.dart';

class Themeapp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _themeappState();
  }
}

class _themeappState extends State<Themeapp> {
  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme'),
      ),
      body: Padding(
        child: RaisedButton(
          color: Theme.of(context).primaryColorDark,
          textColor: Theme.of(context).primaryColorLight,
          child: Text(
            'Theme change coming soon',
            textScaleFactor: 1.5,
          ),
          onPressed: () {
            setState(() {
              debugPrint("Save button clicked");
            });
          },
        ),
      ),
    );
  }
  void currentTheme(String theme){
       
  }
}
