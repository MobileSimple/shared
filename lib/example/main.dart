import 'dart:math';

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
  Future<List<String>> futureItems;
  String selectedItem;
  Future<List<String>> getFutureItems() async {
    await Future.delayed(Duration(milliseconds: 1500));
    final List<String> items = <String>['iSyrop', 'Jira', 'Word'];
    if (Random().nextInt(5) < 4) {
      return Future.value(items);
    } else {
      return Future.error('Błąd podczas wczytywania danych');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('overlay 0.3.0'),
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
          padding: const EdgeInsets.only(
              top: Edges.small, left: Edges.verySmall, right: Edges.verySmall),
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
        separator(size: 2),
        Text('wybrany element: $selectedItem'),
        separator(),
        // top
        item(
          text: 'notification Durations.medium',
          action: () => overlay.showNotification(
            context: context,
            text: 'notification about something',
            duration: overlay.Durations.medium,
          ),
        ),
        separator(),
        // dialog
        item(
          text: 'dialog text and title',
          action: () => overlay.showDialog(
              context: context,
              title: 'Dialog informacyjny',
              text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
        ),
        separator(),
        // bottom
        item(
          text: 'bottom text',
          action: () => overlay.showBottomText(
            context: context,
            text:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
        ),
        item(
          text: 'bottom text Durations.long',
          action: () => overlay.showBottomText(
            context: context,
            duration: overlay.Durations.medium,
            text:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
        ),
        item(
          text: 'bottom items',
          action: () => overlay.showBottomItems(
            context: context,
            items: items,
            itemWidget: (String item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: Edges.verySmall),
              child: Text(item),
            ),
            onSelectedItem: (String item) => setState(() => selectedItem = item),
          ),
        ),
        item(
          text: 'bottom future items',
          action: () => overlay.showBottomFutureItems(
            context: context,
            itemsFuture: getFutureItems(),
            itemWidget: (String item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: Edges.small),
              child: Text(item),
            ),
            onSelectedItem: (String item) => setState(() => selectedItem = item),
          ),
        ),
        separator(),
        // error
        item(
          text: 'error Durations.short',
          action: () => overlay.showError(
            context: context,
            text: 'not working - bad luck',
            duration: overlay.Durations.short,
          ),
        ),
      ],
    );
  }

  Widget item({String text, Function action}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Edges.ultraSmall),
      child: ElevatedButton(
        onPressed: action,
        child: Text(text),
      ),
    );
  }

  Widget separator({double size = 1}) => Container(
        height: size,
        margin: const EdgeInsets.symmetric(vertical: Edges.verySmall),
        color: Theme.of(context).accentColor,
      );
}
