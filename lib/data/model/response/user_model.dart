class UserModel {
  int _id;
  String _username;
  String _firstName;
  String _lastName;
  String _name;
  String _image;
  String _createdAt;

  UserModel(
    int id,
    String username,
    String firstName,
    String lastName,
    String name,
    String image,
    String createdAt,
  ) {
    this._id = id;
    this._username = username;
    this._firstName = firstName;
    this._lastName = _lastName;
    this._name = _name;
    this._image = _image;
    this._createdAt = _createdAt;
  }

  int get id => _id;
  String get username => _username;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get name => _name;
  String get image => _image;
  String get createdAt => _createdAt;

  UserModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _username = json['username'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _name = json['name'];
    _image = json['image'];
    _createdAt = json['created_at'];
  }
}
