import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends ChangeNotifier {
  int? age;
  String? name;
  String? surName;
  String? email;
  String? password;
  late SharedPreferences sharedPref;
  List<String> stringList = new List<String>.empty(growable: true);
  List<User> userList = new List<User>.empty(growable: true);

  User({this.name, this.surName, this.age, this.email, this.password});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "name": this.name,
      "surName": this.surName,
      "age": this.age,
      "email": this.email,
      "password": this.password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"],
      surName: json["surName"],
      age: json["age"],
      email: json["email"],
      password: json["password"],
    );
  }

  Future<void> loadSharedPreferece() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  Future<void> saveUserListToSP() async {
    await loadSharedPreferece();
    stringList = userList.map((elem) => json.encode(elem.toJson())).toList();
    sharedPref.setStringList("userList", stringList);
    notifyListeners();
  }

  Future<void> loadUserListFromSP() async {
    await loadSharedPreferece();
    if (sharedPref.getStringList("userList") != null) {
      stringList = sharedPref.getStringList("userList") as List<String>;
    }
    if (stringList.isNotEmpty) {
      userList = stringList.map((elem) {
        return User.fromJson(json.decode(elem));
      }).toList();
      notifyListeners();
    }
  }

  Future<void> addUser(User user) async {
    userList.insert(0, user);
    print(userList[0].name as String);
    await saveUserListToSP();
  }

  Future<void> removeUser(int index) async {
    userList.removeAt(index);
    await saveUserListToSP();
  }

  Future<void> updateUser(int index, User user) async {
    userList[index] = user;
    await saveUserListToSP();
  }
}
