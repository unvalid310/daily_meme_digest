class LeaderboardModel {
  int _id;
  String _image;
  String _username;
  String _name;
  int _like;

  LeaderboardModel(
    int id,
    String image,
    String username,
    String name,
    int like,
  ) {
    this._id = id;
    this._image = image;
    this._username = username;
    this._name = name;
    this._like = like;
  }

  int get id => _id;
  String get image => _image;
  String get username => _username;
  String get name => _name;
  int get like => _like;

  LeaderboardModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _image = json['image'];
    _username = json['username'];
    _name = json['name'];
    _like = json['like'];
  }
}
