import 'package:flutter/material.dart';
import 'package:shared/example/pages/constants_page.dart';
import 'package:shared/example/pages/ovelray_example_page.dart';
import 'package:shared/utils/theme.dart';
import 'package:shared/example/widgets/item_widget.dart';
import 'package:shared/utils/constants.dart';

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
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('shared 1.4.2'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: Edges.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Edges.medium),
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
              padding: const EdgeInsets.symmetric(horizontal: Edges.medium),
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
