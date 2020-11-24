import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
        primarySwatch: Colors.brown,
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
    String i = buttonval[m];
    return RaisedButton(
      onPressed: () => buttonpress(m),
      child: i.isEmpty
          ? Text('')
          : i == "X"
              ? Text(
                  i,
                  style: TextStyle(color: Colors.black),
                )
              : Text(
                  i,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
      color: i.isEmpty
          ? Colors.grey
          : i == "X"
              ? Colors.red
              : Colors.black,
    );
  }

  final box = BoxDecoration(
    border: Border.all(
      color: Colors.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 1,
            ),
            itemCount: buttonval.length,
            itemBuilder: (context, index) => SizedBox(
              height: 10,
              width: 10,
              child: butupdate(index),
            ),
          ),
        ),
      ),
    );
  }
}
