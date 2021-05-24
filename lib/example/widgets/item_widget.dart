import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class Item extends StatelessWidget {
  final String? text;
  final VoidCallback? action;

  const Item({this.text, this.action, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Edges.ultraSmall),
      child: ElevatedButton(
        onPressed: action != null ? action : action,
        child: Text(text ?? ''),
      ),
    );
  }
}
