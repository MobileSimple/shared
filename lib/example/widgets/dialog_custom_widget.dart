import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class Custom extends StatefulWidget {
  Custom({Key? key}) : super(key: key);

  @override
  _CustomState createState() => _CustomState();
}

class _CustomState extends State<Custom> {
  static const List<String> data = <String>['a', 'b', 'c', 'd'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Edges.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('custom'),
          Row(children: [Switch(value: true, onChanged: (_) {})]),
          TextField(),
          Row(children: [Checkbox(value: false, onChanged: (_) {})]),
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) => Text(
              data[index],
            ),
          ),

          //
          Padding(
            padding: const EdgeInsets.all(50),
            child: Text('custom'),
          ),
          Padding(
            padding: const EdgeInsets.all(50),
            child: Text('custom'),
          ),
          Padding(
            padding: const EdgeInsets.all(50),
            child: Text('custom'),
          ),
        ],
      ),
    );
  }
}
