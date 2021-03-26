import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared/example/widgets/dialog_custom_widget.dart';
import 'package:shared/utils/constants.dart';

import 'package:shared/overlay.dart' as overlay;

import 'widgets/item_widget.dart';

class OverlayPage extends StatefulWidget {
  const OverlayPage({Key key}) : super(key: key);

  @override
  _OverlayPageState createState() => _OverlayPageState();
}

class _OverlayPageState extends State<OverlayPage> {
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

  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: Text('Overlay'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outlined),
            onPressed: () {
              overlay.showDialog(
                context: context,
                title: 'Zależności',
                text:
                    'Do prawidłowego działania funkcji overlay w drzewie Widgetów potrzebny jest "Scaffold"',
              );
            },
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        // child: body(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TabBar(
              labelPadding: EdgeInsets.all(1),
              tabs: [
                Tab(
                  child: Text('dialog', style: TextStyle(color: Colors.black)),
                ),
                Tab(
                  child: Text('karty', style: TextStyle(color: Colors.black)),
                ),
                Tab(
                  child: Text('inne', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  dialogs(),
                  cards(),
                  other(),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(Edges.small),
              child: Text('wybrany element: $selectedItem'),
            ),
          ],
        ),
      ),
    );
  }

  Widget dialogs() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Edges.small),
      child: Column(
        children: [
          Item(
            text: 'dialog text and title',
            action: () => overlay.showDialog(
                context: context,
                title: 'Dialog informacyjny',
                text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
          ),
          Item(
            text: 'dialog confirm',
            action: () => overlay.showDialogConfirm(
              context: context,
              title: 'Potwierdzenie',
              text: 'Czy zmienić kolor ma ${color != Colors.purple ? 'fioletowy' : 'biały'}?',
              onButton: (bool action) {
                if (action) {
                  setState(() => color = color != Colors.purple ? Colors.purple : Colors.white);
                }
              },
            ),
          ),
          Item(
            text: 'dialog custom',
            action: () => overlay.showDialogCustom(
              context: context,
              buttons: <String, Color>{'Przycisk': AppColors.primary},
              onButton: (String button) => print(button),
              backgroundTap: true,
              child: Custom(),
            ),
          ),
        ],
      ),
    );
  }

  Widget cards() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Edges.small),
      child: Column(
        children: [
          Item(
            text: 'bottom text',
            action: () => overlay.showBottomText(
              context: context,
              text:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            ),
          ),
          Item(
            text: 'bottom text Durations.long',
            action: () => overlay.showBottomText(
              context: context,
              duration: overlay.durationMedium,
              text:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            ),
          ),
          Item(
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
          Item(
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
          Item(
            text: 'bottom confirm',
            action: () => overlay.showBottomConfirm(
                context: context,
                title: 'Potwierdzenie',
                text: 'Czy zmienić kolor ma ${color != Colors.purple ? 'fioletowy' : 'biały'}?',
                onButton: (bool action) {
                  if (action) {
                    setState(() => color = color != Colors.purple ? Colors.purple : Colors.white);
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget other() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: Edges.small),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Item(
            text: 'notification Durations.medium',
            action: () => overlay.showNotification(
              context: context,
              text: 'notification about something',
              duration: overlay.durationMedium,
            ),
          ),
          Item(
            text: 'error Durations.short',
            action: () => overlay.showError(
              context: context,
              text: 'not working - bad luck',
              duration: overlay.durationShort,
            ),
          ),
        ],
      ),
    );
  }
}
