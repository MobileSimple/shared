import 'package:shared_nullsafety/utils/logger.dart';

const String actionScanner = 'scanner';
const String actionStart = 'start';
const String actionStop = 'stop';
const String actionAdd = 'add';
const String actionPrint = 'print';
const String actionPosition = 'position';
const String actionType = 'typ';
const String actionWarehouse = 'warehouse';
const String actionSearch = 'search';
const String actionEndStatus = 'endStatus';
const String actionReturn = 'return';
const String actionWriteDown = 'writeDown';
const String actionEndWriteDown = 'endWriteDown';
const String actionNewPage = 'newPage';

mixin ControlledActions {
  final Map<String, bool> _hs = <String, bool>{};

  Future<void> onPressed(String key, Function() action, {bool awaitOthers = false}) async {
    if (awaitOthers && _hs.values.any((bool e) => e)) {
      return;
    }
    if (!_hs.containsKey(key)) {
      _hs.addAll(<String, bool>{key: false});
    }
    if (!_hs[key]!) {
      _hs[key] = true;
      Logger.action(key, args: awaitOthers ? <String, dynamic>{'awaitOthers': false} : null);
      await action?.call();
      _hs[key] = false;
    }
    return;
  }
}

class _ControlledActionsWrapper with ControlledActions {}

class GlobalControlledActions {
  static _ControlledActionsWrapper? _instance;

  GlobalControlledActions.init() {
    _instance = _ControlledActionsWrapper();
  }

  static Future<void> onPressed(Function() action, {String? key}) => _instance!.onPressed(key!, action);
}

// TODO reconsider as widget
// class Test extends StatefulWidget {
//   final Function() onPressed;
//   final Widget child;

//   const Test({@required this.onPressed, @required this.child, Key key}) : super(key: key);

//   @override
//   _TestState createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   bool active = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         if (active) {
//           return log('oczekuje');
//         }
//         if (!active) {
//           active = true;
//           await widget.onPressed?.call();
//           active = false;
//         }
//       },
//       child: widget.child,
//     );
//   }
// }
