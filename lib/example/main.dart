import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/theme.dart';
import 'pages/constants_page.dart';
import 'pages/overlay_example_page.dart';
import 'widgets/item_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.init(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('shared 1.3.0'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: Edges.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Edges.medium),
              child: Item(
                text: 'overlay',
                action: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OverlayPage()),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Edges.medium),
              child: Item(
                text: 'constants',
                action: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConstantsPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
