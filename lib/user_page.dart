import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                        "User Details",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: 350,
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: 350,
                    child: TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: 350,
                    child: TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Text(
                          "Notifications",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Transform.scale(
                          scale: 1,
                          child: Switch(
                            onChanged: toggleSwitch,
                            value: isSwitched,
                            activeColor: Colors.blue,
                            activeTrackColor: Colors.yellow,
                            inactiveThumbColor: Colors.redAccent,
                            inactiveTrackColor: Colors.orange,
                          )
                        ),
                      ]
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ), TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Save'),
                    ),
                ]
              )
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent)
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Start New",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 280, 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.black12
                      ),
                      onPressed: () {
                        final snackBar = SnackBar(
                          content: const Text(
                            'Can\'t do that right now',
                          ),
                          action: SnackBarAction(
                            label: 'Okay',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Text('Reset'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    "Say Goodbye",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 300, 0),
              child: Column(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black12
                    ),
                    onPressed: () {
                      final snackBar = SnackBar(
                        content: const Text(
                            'You haven\'t actually log-inned yet',
                        ),
                        action: SnackBarAction(
                          label: 'Okay',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Text('Logout'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black12
                    ),
                    onPressed: () {
                      final snackBar = SnackBar(
                        content: const Text(
                          'You don\'t have an account to delete',
                        ),
                        action: SnackBarAction(
                          label: 'Okay',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Text('Delete'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
