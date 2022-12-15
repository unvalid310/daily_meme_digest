class LikeModel {
  int _id;
  String _username;
  String _firstName;
  String _lastName;
  String _name;
  String _image;
  LikeModel(
    int id,
    String username,
    String firstName,
    String lastName,
    String name,
    String image,
  ) {
    this._id = id;
    this._username = username;
    this._firstName = firstName;
    this._lastName = lastName;
    this._name = name;
    this._image = image;
  }

  int get id => _id;
  String get username => _username;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get name => _name;
  String get image => _image;

  LikeModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _username = json['username'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _name = json['name'];
    _image = json['image'];
  }
}
