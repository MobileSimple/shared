import 'package:flutter/material.dart';
import 'package:shared/utils/constants.dart';

class Item extends StatelessWidget {
  final String text;
  final Function action;

  const Item({this.text, this.action, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Edges.ultraSmall),
      child: ElevatedButton(
        onPressed: action,
        child: Text(text),
      ),
    );
  }
}
