import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  int current = 0;

  void add(int number) {
    current += number;
    notifyListeners();
  }

  void reset() {
    current = 0;
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    int count = appState.current;

    return Scaffold(
      appBar: AppBar(
        title: Text('Decklist Counter'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(count.toString(), textScaleFactor: 5),
            ),
            ResetButton(resetFunction: () {
              appState.reset();
            }),
            FourButtons(addFunction: (number) {
              appState.add(number);
            })
          ],
        ),
      ),
    );
  }
}

class ResetButton extends StatelessWidget {
  const ResetButton({
    super.key,
    required this.resetFunction,
  });

  final Function resetFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
          onPressed: () {
            resetFunction();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Reset',
              textScaleFactor: 3,
              style: TextStyle(color: Colors.black),
            ),
          )),
    );
  }
}

class FourButtons extends StatelessWidget {
  const FourButtons({super.key, required this.addFunction});

  final Function addFunction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          AddButton(addFunction: addFunction, additive: 1),
          AddButton(addFunction: addFunction, additive: 2),
          AddButton(addFunction: addFunction, additive: 3),
          AddButton(addFunction: addFunction, additive: 4)
        ],
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton(
      {super.key, required this.addFunction, required this.additive});

  final Function addFunction;
  final int additive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          )),
          onPressed: () {
            addFunction(additive);
          },
          child: Text(
            '+$additive',
            textScaleFactor: 5,
          )),
    );
  }
}
