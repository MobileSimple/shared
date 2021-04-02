import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared/example/widgets/dialog_custom_widget.dart';
import 'package:shared/utils/constants.dart';
import 'package:shared/overlay/overlay.dart' as overlay;

class OverlayPage extends StatefulWidget {
  const OverlayPage({Key key}) : super(key: key);

  @override
  _OverlayPageState createState() => _OverlayPageState();
}

class _OverlayPageState extends State<OverlayPage> {
  String info;
  Color color = Colors.blue;
  Future<List<String>> get future async {
    await Future.delayed(Duration(milliseconds: 1500));
    final List<String> items = <String>['iSyrop', 'Jira', 'Word'];
    if (Random().nextInt(5) < 4) {
      return Future.value(items);
    } else {
      return Future.error('Błąd podczas wczytywania danych');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ButtonStyle(
      visualDensity: VisualDensity(horizontal: -1, vertical: -3),
    );
    return WillPopScope(
      onWillPop: () => Future.value(!overlay.hideLast()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('overlay: $info'),
          backgroundColor: color,
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GridView.count(
                primary: false,
                crossAxisCount: 3,
                childAspectRatio: 3,
                children: <Widget>[
                  TextButton(
                    style: buttonStyle,
                    onPressed: () => overlay.showText(context, 'text'),
                    child: Text('text', style: TextStyle(fontSize: FontSizes.small)),
                  ),
                  TextButton(
                    style: buttonStyle,
                    onPressed: () => overlay.showTitleText(context, 'tytuł', 'text'),
                    child: Text(
                      'text & title',
                      style: TextStyle(fontSize: FontSizes.small),
                    ),
                  ),
                  TextButton(
                    style: buttonStyle,
                    onPressed: () async {
                      final String data = await overlay.showText(
                        context,
                        'text',
                        buttons: <String, Color>{
                          'syrop': Colors.green,
                          'tak': AppColors.accent,
                          'nie': AppColors.red,
                        },
                      );
                      setState(() {
                        if (data != null) {
                          info = data;
                        }
                      });
                    },
                    child: Text(
                      'text & buttons',
                      style: TextStyle(fontSize: FontSizes.small),
                    ),
                  ),
                  TextButton(
                    style: buttonStyle,
                    onPressed: () async {
                      const String identifier = 'testowy';
                      await overlay.showCustom(
                        context,
                        Custom(),
                        identifier: identifier,
                      );
                    },
                    child: Text(
                      'child',
                      style: TextStyle(fontSize: FontSizes.small),
                    ),
                  ),
                  TextButton(
                    style: buttonStyle,
                    onPressed: () async {
                      final bool confirm = await overlay.showConfirm(
                        context,
                        'Potwierdzenie',
                        'Czy zmienić kolor na ${color == Colors.purple ? 'Niebieski' : 'Fioletowy'}?',
                      );
                      if (confirm) {
                        setState(
                          () => color = color == Colors.purple ? Colors.blue : Colors.purple,
                        );
                      }
                    },
                    child: Text('confirm', style: TextStyle(fontSize: FontSizes.small)),
                  ),
                  TextButton(
                    style: buttonStyle,
                    onPressed: () async {
                      final String data = await overlay.showItems(
                        context,
                        <String>[
                          'poniedziałek',
                          'wtorek',
                          'środa',
                          'czwartek',
                          'piątek',
                          'sobota',
                          'niedziela',
                        ],
                        (String item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: Edges.small),
                          child: Text(
                            item,
                            style: TextStyle(fontSize: FontSizes.large),
                          ),
                        ),
                        backgroundTap: true,
                      );
                      setState(() {
                        if (data != null) {
                          info = data;
                        }
                      });
                    },
                    child: Text(
                      'items list',
                      style: TextStyle(fontSize: FontSizes.small),
                    ),
                  ),
                  TextButton(
                    style: buttonStyle,
                    onPressed: () async {
                      final String data = await overlay.showItemsFuture(
                        context,
                        future,
                        (String item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: Edges.small),
                          child: Text(
                            item,
                            style: TextStyle(fontSize: FontSizes.large),
                          ),
                        ),
                        backgroundTap: true,
                      );
                      setState(() {
                        if (data != null) {
                          info = data;
                        }
                      });
                    },
                    child: Text(
                      'items future list',
                      style: TextStyle(fontSize: FontSizes.small),
                    ),
                  ),
                  TextButton(
                    style: buttonStyle,
                    onPressed: () => overlay.showError(context, 'treść błędu'),
                    child: Text('error', style: TextStyle(fontSize: FontSizes.small)),
                  ),
                  TextButton(
                    style: buttonStyle,
                    onPressed: () => overlay.showNotification(context, 'treść notyfikacji'),
                    child: Text('notification', style: TextStyle(fontSize: FontSizes.small)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
