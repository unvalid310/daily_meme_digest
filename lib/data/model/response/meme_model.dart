import 'package:daily_meme_digest/data/model/response/comment_model.dart';
import 'package:daily_meme_digest/data/model/response/like_model.dart';

class MemeModel {
  int _id;
  String _image;
  String _date;
  List<LikeModel> _like;
  bool _isLike;
  int _likeCount;
  List<CommentModel> _comment;
  int _commentCount;
  int _visitorCount;

  MemeModel(
    int id,
    String image,
    String date,
    List<LikeModel> like,
    bool isLike,
    int likeCount,
    List<CommentModel> comment,
    int commentCount,
    int visitorCount,
  ) {
    this._id = id;
    this._image = image;
    this._date = date;
    this._like = like;
    this._isLike = isLike;
    this._likeCount = likeCount;
    this._comment = comment;
    this._commentCount = commentCount;
    this._visitorCount = visitorCount;
  }

  int get id => _id;
  String get image => _image;
  String get date => _date;
  List<LikeModel> get like => _like;
  bool get isLike => _isLike;
  int get likeCount => _likeCount;
  List<CommentModel> get comment => _comment;
  int get commentCount => _commentCount;
  int get visitorCount => _visitorCount;

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

    List<LikeModel> _likeList = [];
    if (json['likes'] != null) {
      json['likes']
          .map((like) => _likeList.add(LikeModel.fromJson(like)))
          .toList();
    }

    _id = json['id'];
    _image = json['image'];
    _date = json['date'];
    _like = _likeList;
    _isLike = json['is_likes'];
    _likeCount = json['like_count'];
    _comment = _commentList;
    _commentCount = json['comment_count'];
    _visitorCount = json['visitor_count'];
  }
}
