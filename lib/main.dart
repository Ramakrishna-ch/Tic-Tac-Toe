import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Tic Tac Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> gameval = [
    "X",
    "O",
  ];
  List<String> buttonval = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  String curr;
  String won;
  bool search(String x) {
    if ((buttonval[0] == x && buttonval[1] == x && buttonval[2] == x) ||
        (buttonval[3] == x && buttonval[4] == x && buttonval[5] == x) ||
        (buttonval[6] == x && buttonval[7] == x && buttonval[8] == x) ||
        (buttonval[0] == x && buttonval[3] == x && buttonval[6] == x) ||
        (buttonval[1] == x && buttonval[4] == x && buttonval[7] == x) ||
        (buttonval[2] == x && buttonval[5] == x && buttonval[8] == x) ||
        (buttonval[0] == x && buttonval[4] == x && buttonval[8] == x) ||
        (buttonval[2] == x && buttonval[4] == x && buttonval[6] == x)) {
      return true;
    }
    return false;
  }

  void buttonpress(int a) {
    if (buttonval[a].isNotEmpty) {
      return;
    }
    if (curr == null) {
      setState(() {});
      buttonval[a] = "X";
      curr = "X";
    } else if (curr == "X") {
      setState(() {});
      buttonval[a] = "O";
      curr = "O";
    } else if (curr == "O") {
      setState(() {});
      buttonval[a] = "X";
      curr = "X";
    }
    if (search(curr)) {
      won = curr;
      _ackAlert(context);
    }
  }

  void cleardat(BuildContext context) {
    setState(() {});
    won = null;
    curr = null;
    for (int i = 0; i < 9; i++) {
      buttonval[i] = '';
    }
    Navigator.of(context).pop();
  }

  Future _ackAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Winner'),
          content: Text('${won} won the game!!! Congratulations'),
          actions: [
            FlatButton(
              child: Text('Close'),
              onPressed: () => cleardat(context),
            ),
          ],
        );
      },
    );
  }

  Widget butupdate(int m) {
    return OutlineButton(
      onPressed: () => buttonpress(m),
      child: buttonval[m].isEmpty ? Text('') : Text(buttonval[m]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 85,
                    child: butupdate(0),
                  ),
                  Container(
                    height: 85,
                    child: butupdate(1),
                  ),
                  Container(
                    height: 85,
                    child: butupdate(2),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 85,
                    child: butupdate(3),
                  ),
                  Container(
                    height: 85,
                    child: butupdate(4),
                  ),
                  Container(
                    height: 85,
                    child: butupdate(5),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 85,
                    child: butupdate(6),
                  ),
                  Container(
                    height: 85,
                    child: butupdate(7),
                  ),
                  Container(
                    height: 85,
                    child: butupdate(8),
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
