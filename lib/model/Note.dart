
class Note{
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  Note(this._title,this._date,this._priority,[this._description]);

  Note.withid(this._id,this._title,this._date,this._priority,[this._description]);

  int get id => _id;
  String get title => _title;
  String get description => _description;
  int get priority => _priority;
  String get date => _date;

  set title(String string){
    this._title=string;
  }

  set description(String string){
    this._description = string;
  }
  set priority(int data){
    if(data ==1 || data==2){
      this._priority = data;
    }
  }
  set date(String date){
    this._date = date;
  }

  Map<String, dynamic> toMap(){
     var map = Map<String,dynamic>();
     if(id!=null){
       map["id"]= _id;
     }
     map["title"]=_title;
     map["description"]=_description;
     map["priority"]=_priority;
     map["date"]=_date;

     return map;
  }

  Note.fromMapObject(Map<String,dynamic> map){
    this._id =map["id"];
    this._title= map["title"];
    this._description = map["description"];
    this._priority = map["priority"];
    this._date = map["date"];

  }

}