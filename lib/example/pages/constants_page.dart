import 'package:flutter/material.dart';
import 'package:shared/utils/constants.dart';

class ConstantsPage extends StatelessWidget {
  const ConstantsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Constants'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Edges.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            color('AppColors.accent', AppColors.accent),
            color('AppColors.primary', AppColors.primary),
            color('AppColors.red', AppColors.red),
            SizedBox(height: Edges.large),
            edge('Edges.ultraSmall', Edges.ultraSmall),
            edge('Edges.verySmall', Edges.verySmall),
            edge('Edges.small', Edges.small),
            edge('Edges.medium', Edges.medium),
            edge('Edges.large', Edges.large),
            edge('Edges.veryLarge', Edges.veryLarge),
            edge('Edges.ultraLarge', Edges.ultraLarge),
            SizedBox(height: Edges.large),
            font('FontSizes.verySmall', FontSizes.verySmall),
            font('FontSizes.small', FontSizes.small),
            font('FontSizes.medium', FontSizes.medium),
            font('FontSizes.large', FontSizes.large),
            font('FontSizes.verySmall', FontSizes.veryLarge),
          ],
        ),
      ),
    );
  }

  Widget color(String name, Color color) {
    return Container(
      color: color,
      padding: const EdgeInsets.all(Edges.verySmall),
      child: Text(
        name,
        style: TextStyle(
          fontSize: FontSizes.small,
          color: color.computeLuminance() > 0.3 ? Colors.black : Colors.white,
        ),
      ),
    );
  }

  Widget edge(String name, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Edges.ultraSmall),
      child: Row(
        children: [
          Text(name, style: TextStyle(fontSize: FontSizes.small)),
          SizedBox(width: Edges.small),
          Expanded(
            child: Container(
              color: Colors.black,
              height: value,
            ),
          ),
        ],
      ),
    );
  }

  Widget font(String name, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Edges.verySmall),
      child: Text(
        name,
        style: TextStyle(fontSize: value),
      ),
    );
  }
}
