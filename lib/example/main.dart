import 'package:flutter/material.dart';
import 'package:shared/utils/constants.dart';

import 'package:shared/overlay.dart' as overlay;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> items = <String>[
    'poniedziałek',
    'wtorek',
    'środa',
    'czwartek',
    'piątek',
    'sobota',
    'niedziela',
  ];
  String selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('overlay 0.1.4'),
      ),
      body: body(),
    );
  }

  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.warning, color: Colors.red),
              Text(
                'scaffold is needed in given BuildContext tree',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Icon(Icons.warning, color: Colors.red),
            ],
          ),
        ),
        Container(
          height: 2,
          margin: const EdgeInsets.symmetric(vertical: 10),
          color: Theme.of(context).accentColor,
        ),
        if (selectedItem != null) Text('wybrany element: $selectedItem') else Text(''),
        ElevatedButton(
          onPressed: () => overlay.showBottomText(
            context: context,
            text:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          child: Text('bottom text'),
        ),
        ElevatedButton(
          onPressed: () => overlay.showBottomText(
            context: context,
            duration: overlay.Durations.medium,
            text:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          child: Text('bottom text Durations.long'),
        ),
        ElevatedButton(
          onPressed: () => overlay.showError(
            context: context,
            text: 'not working - bad luck',
            duration: overlay.Durations.short,
          ),
          child: Text('error Durations.short'),
        ),
        ElevatedButton(
          onPressed: () => overlay.showNotification(
            context: context,
            text: 'notification about something',
            duration: overlay.Durations.medium,
          ),
          child: Text('notification Durations.medium'),
        ),
        ElevatedButton(
          onPressed: () => overlay.showBottomItems(
            context: context,
            items: items,
            itemWidget: (String item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: Edges.verySmall),
              child: Text(item),
            ),
            onSelectedItem: (String item) => setState(() => selectedItem = item),
          ),
          child: Text('bottom items'),
        ),
        ElevatedButton(
          onPressed: () => overlay.showDialog(
              context: context,
              title: 'Dialog informacyjny',
              text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
          child: Text('dialog text and title'),
        ),
      ],
    );
  }
}
