class CommentModel {
  int _id;
  String _name;
  String _date;
  String _comment;

  CommentModel(
    int id,
    String name,
    String date,
    String comment,
  ) {
    this._id = id;
    this._name = name;
    this._date = date;
    this._comment = comment;
  }

  int get id => _id;
  String get name => _name;
  String get date => _date;
  String get comment => _comment;

  CommentModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _date = json['date'];
    _comment = json['comment'];
  }
}
