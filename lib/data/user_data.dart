class UserData {
  String _name, _email, _address;

  UserData(this._name, this._email, this._address);

  Map<String, dynamic> toMap() {
    var userMap = Map<String, dynamic>();
    userMap["name"] = this._name;
    userMap["email"] = this._email;
    userMap["_address"] = this._address;
    return userMap;
  }

  get address => _address;

  get email => _email;

  String get name => _name;
}