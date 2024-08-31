import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<String> present = [];
  List<String> absent = [];
  List<String> dismissedRolls = [];

  //change the roll numbers as per your requirement
  final List<String> rollList = [
    '22z201',
    '22Z202',
    '22Z203',
    '22Z204',
    '22Z206',
    '22Z208',
    '22z209',
    '22Z210',
    '22Z211',
    '22z212',
    '22z213',
    '22z214',
    '22z215',
    '22z216',
    '22z217',
    '22Z218',
    '22z219',
    '22z220',
    '22z221',
    '22z222',
    '22z223',
    '22z224',
    '22z225',
    '22z226',
    '22z227',
    '22z228',
    '22z229',
    '22z231',
    '22z232',
    '22Z233',
    '22z234',
    '22z235',
    '22z236',
    '22z237',
    '22z238',
    '22z239',
    '22Z240',
    '22z241',
    '22z242',
    '22z243',
    '22z244',
    '22z245',
    '22z246',
    '22z247',
    '22z248',
    '22Z249',
    '22z250',
    '22Z251',
    '22Z252 ',
    '22Z253',
    '22Z254',
    '22Z255',
    '22z256',
    '22z257',
    '22Z258',
    '22Z259',
    '22z260',
    '22z261',
    '22z262',
    '22z263',
    '22Z264',
    '22z265',
    '22Z266',
    '22z267',
    '22z268',
    '22Z269 ',
    '22z270',
    '22z271',
    '22z272',
    '22z273',
    '22z274',
    '22z275',
    '22z276',
    '22z277',
    '22z278',
    '22z279',
    '22z280',
    '22z433',
    '23z431',
    '23z432',
    '23z433',
    '23z434',
    '23z435',
    '23z436',
    '23z438'
  ];

  void markPresent(String roll) {
    setState(() {
      present.add(roll);
      dismissedRolls.add(roll);
      rollList.remove(roll);
    });
  }

  void markAbsent(String roll) {
    setState(() {
      absent.add(roll);
      dismissedRolls.add(roll);
      rollList.remove(roll);
    });
  }

  void undoLastAction() {
    if (dismissedRolls.isNotEmpty) {
      setState(() {
        String lastRoll = dismissedRolls.removeLast();
        present.remove(lastRoll);
        absent.remove(lastRoll);
        rollList.insert(0, lastRoll);
      });
    }
  }

  AlertDialog showList(BuildContext context) {
    String exportText =
        "Present: ${present.join(", ")}\nAbsent: ${absent.join(", ")}";

    return AlertDialog(
      title: const Text("Attendance"),
      content: SelectableText(exportText),
      actions: [
        TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: exportText));
              Navigator.of(context).pop();
            },
            child: const Text("Export")),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Close"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showList(context);
                },
              );
            },
            child: const Icon(Icons.save),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: undoLastAction,
            child: const Icon(Icons.undo),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: List.generate(
          rollList.length,
          (index) => RollCall(
            roll: rollList[rollList.length - index - 1],
            onPresent: markPresent,
            onAbsent: markAbsent,
          ),
        ),
      ),
    );
  }
}

class RollCall extends StatelessWidget {
  final String roll;
  final Function(String) onPresent;
  final Function(String) onAbsent;

  RollCall({
    required this.roll,
    required this.onPresent,
    required this.onAbsent,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      movementDuration: const Duration(microseconds: 10),
      resizeDuration: const Duration(milliseconds: 10),
      key: Key(roll),
      background: Container(
        color: Colors.green, // First background color
        child: Center(
          child: Text(
            roll,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 64,
            ),
          ),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red, // Second background color
        child: Center(
          child: Text(
            roll,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 64,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          HapticFeedback.heavyImpact();
          onPresent(roll);
        } else if (direction == DismissDirection.endToStart) {
          HapticFeedback.heavyImpact();
          Future.delayed(Duration(milliseconds: 100), () {
            HapticFeedback.heavyImpact();
          });
          onAbsent(roll);
        }
      },
      child: Container(
        color: Colors.grey,
        child: Center(
          child: Text(
            roll,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 64,
            ),
          ),
        ),
      ),
    );
  }
}
