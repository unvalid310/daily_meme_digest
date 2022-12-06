import 'package:daily_meme_digest/data/model/response/comment_model.dart';

class MemeModel {
  int _id;
  String _image;
  String _date;
  int _like;
  List<CommentModel> _comment;

  MemeModel(
    int id,
    String image,
    String date,
    int like,
    List<CommentModel> comment,
  ) {
    this._id = id;
    this._image = image;
    this._date = date;
    this._like = like;
    this._comment = comment;
  }

  int get id => _id;
  String get image => _image;
  String get date => _date;
  int get like => _like;
  List<CommentModel> get comment => _comment;

  MemeModel.fromJson(Map<String, dynamic> json) {
    List<CommentModel> _commentList = [];
    if (json['comment'] != null) {
      json['comment']
          .map(
            (comment) => _commentList.add(
              CommentModel.fromJson(comment as Map<String, dynamic>),
            ),
          )
          .toList();
    }

    _id = json['id'];
    _image = json['image'];
    _date = json['date'];
    _like = json['like'];
    _comment = _commentList;
  }
}
