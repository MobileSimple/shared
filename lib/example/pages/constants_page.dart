import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class ConstantsPage extends StatelessWidget {
  const ConstantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(title: Text('Constants')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: color(context, 'accent', AppColors.accent)),
              Expanded(child: color(context, 'primary', AppColors.primary)),
              Expanded(child: color(context, 'red', AppColors.redDark)),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(Edges.small),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                edge(context, 'Edges.ultraSmall', Edges.ultraSmall),
                edge(context, 'Edges.verySmall', Edges.verySmall),
                edge(context, 'Edges.small', Edges.small),
                edge(context, 'Edges.medium', Edges.medium),
                edge(context, 'Edges.large', Edges.large),
                edge(context, 'Edges.veryLarge', Edges.veryLarge),
                edge(context, 'Edges.ultraLarge', Edges.ultraLarge),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Edges.small),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    font(context, 'headline1', tt.headline1!),
                    font(context, 'headline2', tt.headline2!),
                    font(context, 'headline3', tt.headline3!),
                    font(context, 'headline4', tt.headline4!),
                    font(context, 'headline5', tt.headline5!),
                    font(context, 'headline6', tt.headline6!),
                    font(context, 'subtitle1', tt.subtitle1!),
                    font(context, 'subtitle2', tt.subtitle2!),
                    font(context, 'bodyText1', tt.bodyText1!),
                    font(context, 'bodyText2', tt.bodyText2!),
                    font(context, 'caption', tt.caption!),
                    font(context, 'overline', tt.overline!),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget color(BuildContext context, String name, Color color) {
    return Container(
      color: color,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(Edges.small),
      child: Text(
        name,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: color.computeLuminance() > 0.3 ? Colors.black : Colors.white,
            ),
      ),
    );
  }

  Widget edge(BuildContext context, String name, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Edges.ultraSmall),
      child: Row(
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.overline,
          ),
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

  Widget font(BuildContext context, String name, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Edges.verySmall),
      child: Text(name, style: style),
    );
  }
}
