import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared/example/widgets/item_widget.dart';
import 'package:shared/example/overlay_page.dart';
import 'package:shared/utils/constants.dart';

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

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('shared 0.5.3'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Edges.medium, vertical: Edges.small),
            child: Item(
                text: 'overlay',
                action: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OverlayPage()));
                }),
          ),
        ],
      ),
    );
  }
}
