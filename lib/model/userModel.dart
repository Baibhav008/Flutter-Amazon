import 'dart:convert';

class User
{
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String stamp;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
  required this.stamp});

  Map<String,dynamic> fromAppToDB()
  {
    return{
      'id' : id,
      'name' : name,
      'email' : email,
      'password' : password,
      'address' : address,
      'type' : type,
      'stamp' : stamp
    };
  }

  factory User.fromDBToApp(Map<String,dynamic> map)
  {
    return User(
    id: map['id']??'',
    name: map['name']??'',
  email: map['email']??'',
  password: map['password']??'',
  address: map['address']??'',
  type: map['type']??'',
        stamp: map['stamp']??'');
  }

  factory User.fromJson(String source) =>User.fromDBToApp(jsonDecode(source));

}