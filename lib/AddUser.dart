import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'User.dart';

class AddUser extends StatefulWidget {
  final bool? isUpdateForm;
  final int? itemIndex;
  const AddUser({key, this.isUpdateForm, this.itemIndex}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  late List<TextEditingController> controllerList;

  @override
  void initState() {
    super.initState();
    controllerList = List.generate(5, (index) => new TextEditingController());
    var user = Provider.of<User>(context, listen: false);

    if (widget.isUpdateForm as bool) {
      var itemIndex = widget.itemIndex as int;
      controllerList[0].text = user.userList[itemIndex].name as String;
      controllerList[1].text = user.userList[itemIndex].surName as String;
      controllerList[2].text = user.userList[itemIndex].age.toString();
      controllerList[3].text = user.userList[itemIndex].email as String;
      controllerList[4].text = user.userList[itemIndex].password as String;
    }
  }

  //User ekleme
  void addUser() {
    var user = Provider.of<User>(context, listen: false);
    User tempUser = new User(
      name: controllerList[0].text,
      surName: controllerList[1].text,
      age: int.parse(controllerList[2].text),
      email: controllerList[3].text,
      password: controllerList[4].text,
    );

    user.addUser(tempUser);

    Navigator.of(context).pop();
  }

  void updateUser(int itemIndex) {
    var user = Provider.of<User>(context, listen: false);

    user.updateUser(
      itemIndex,
      User(
        name: controllerList[0].text,
        surName: controllerList[1].text,
        age: int.parse(controllerList[2].text),
        email: controllerList[3].text,
        password: controllerList[4].text,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var itemIndex;
    if (widget.itemIndex != null) {
      itemIndex = widget.itemIndex as int;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.isUpdateForm == false ? "Add User" : "Update User"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "İsim",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  controller: controllerList[0],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Soyİsim",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  controller: controllerList[1],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Yaş",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  controller: controllerList[2],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "E-Posta",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  controller: controllerList[3],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  controller: controllerList[4],
                ),
              ),
              MaterialButton(
                onPressed: () => widget.isUpdateForm == false
                    ? addUser()
                    : updateUser(itemIndex),
                child: Text(
                  "KAYDET",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                color: Colors.blue,
                minWidth: 370,
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }
}
