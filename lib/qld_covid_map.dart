import 'package:flutter/material.dart';

class QLDCovidMap extends StatefulWidget {
  const QLDCovidMap({Key? key}) : super(key: key);

  @override
  State<QLDCovidMap> createState() => _QLDCovidMapState();
}

class _QLDCovidMapState extends State<QLDCovidMap> {
  int _counter = 0;

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QLD Covid Map")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
