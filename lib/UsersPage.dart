import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AddUser.dart';
import 'User.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    super.initState();
    loadUserList();
  }

  void loadUserList() async {
    var user = Provider.of<User>(context, listen: false);
    await user.loadUserListFromSP();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("UsersPage"),
        centerTitle: true,
      ),
      body: user.userList.isEmpty
          ? Center(child: Text("List Empty"))
          : ListView.separated(
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(user.userList[index].hashCode.toString()),
                  child: ListTile(
                    title: Text(user.userList[index].name.toString()),
                    onLongPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            AddUser(isUpdateForm: true, itemIndex: index),
                      ));
                    },
                  ),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) => user.removeUser(index),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black,
                  thickness: 0.8,
                  height: 4,
                );
              },
              itemCount: user.userList.length,
              scrollDirection: Axis.vertical,
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddUser(isUpdateForm: false),
            ),
          );
        },
      ),
    );
  }
}
