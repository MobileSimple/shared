import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Logger {
  static Map<String, dynamic>? _history;
  static File? _file;

  static String get _timeStamp => DateTime.now().toIso8601String();

  static Future<void> init() async {
    String path = '';
    if (Platform.isAndroid) {
      path = (await getExternalStorageDirectory())!.path;
    } else if (Platform.isIOS) {
      path = (await getApplicationDocumentsDirectory()).path;
    }
    log(path);
    _history = <String, dynamic>{};
    _file = File('$path/mMagazyn_log.txt');
    await _log('init', '', {}, fileMode: FileMode.writeOnly);
  }

  static void action(String message, {Map<String, dynamic>? args}) => _log(message, 'ACTION | ', args ?? {});
  static void error(String message, {Map<String, dynamic>? args}) => _log(message, 'ERROR | ', args ?? {});
  static void exception(String message, {Map<String, dynamic>? args}) => _log(message, 'EXCEPTION | ', args ?? {});
  static void http(String message, {Map<String, dynamic>? args}) => _log(message, 'HTTP | ', args ?? {});
  static void navigation(String message, {Map<String, dynamic>? args}) => _log(message, 'NAVIGATION | ', args ?? {});

  static Future<void> _log(String? message, String? prefix, Map<String, dynamic>? args, {FileMode fileMode = FileMode.writeOnlyAppend}) async {
    final StringBuffer sb = StringBuffer();
    sb.write(prefix ?? '');
    sb.write(message ?? '');
    if (args != null && args.isNotEmpty) {
      sb.write('\t');
      sb.write(args.toString());
    }
    final String? data = sb.toString();
    log(data ?? 'no message');
    _historyAdd(_timeStamp, data);
    await _file!.writeAsString('$_timeStamp: $data', mode: fileMode);
  }

  static void _historyAdd(String key, dynamic value) {
    if (_history != null) {
      if (_history!.containsKey(key)) {
        _history![key] += '\n$value';
        return;
      }
      _history!.addAll(<String, dynamic>{key: value});
    }
  }

  @override
  String toString() => _history?.toString() ?? 'no logs';
}
