import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  List<String> present = [];
  List<String> absent = [];

  final List<String> rollList = [
    "22Z201",
    "22Z202",
    "22Z203",
    "22Z204",
    "22Z205",
    "22Z206",
    "22Z207",
    "22Z208",
    "22Z209",
    "22Z210",
    "22Z211",
    "22Z212",
    "22Z213",
    "22Z214",
    "22Z215",
    "22Z216",
    "22Z217",
    "22Z218",
    "22Z219",
    "22Z220",
    "22Z221",
    "22Z222",
    "22Z223",
    "22Z224",
    "22Z225",
    "22Z226",
    "22Z227",
    "22Z228",
    "22Z229",
    "22Z230",
    "22Z231",
    "22Z232",
    "22Z233",
    "22Z234",
    "22Z235",
    "22Z236",
    "22Z237",
    "22Z238",
    "22Z239",
    "22Z240",
    "22Z241",
    "22Z242",
    "22Z243",
    "22Z244",
    "22Z245",
    "22Z246",
    "22Z247",
    "22Z248",
    "22Z249",
    "22Z250",
    "22Z251",
    "22Z252",
    "22Z253",
    "22Z254",
    "22Z255",
    "22Z256",
    "22Z257",
    "22Z258",
    "22Z259",
    "22Z260",
    "22Z261",
    "22Z262",
    "22Z263",
    "22Z264",
    "22Z265",
    "22Z266",
    "22Z267",
    "22Z268",
    "22Z269",
    "22Z270",
    "22Z271",
    "22Z272",
    "22Z273",
    "22Z274",
    "22Z275",
    "22Z276",
    "22Z277",
    "22Z278",
    "22Z279",
    "22Z280"
  ];

  void markPresent(String roll) {
    present.add(roll);
  }

  void markAbsent(String roll) {
    absent.add(roll);
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
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
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
        body: Stack(
            alignment: Alignment.center,
            children: List.generate(
                rollList.length,
                (index) => RollCall(
                    roll: rollList[rollList.length - index - 1],
                    onPresent: markPresent,
                    onAbsent: markAbsent))),
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
      key: Key(roll),
      background: Container(
        color: Colors.blue, // First background color
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
          onPresent(roll);
        } else if (direction == DismissDirection.endToStart) {
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
