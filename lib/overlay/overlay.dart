import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/overlay/cubit/overlay_cubit.dart';
import 'package:shared/overlay/widget/overlay_widget.dart';
import 'package:shared/utils/constants.dart';
import 'package:uuid/uuid.dart';

// ############################################################################
/// Shows card with given text
Future<String> showText(
  BuildContext context,
  String text, {
  Map<String, Color> buttons,
  bool backgroundTap = true,
}) =>
    show(
      context,
      Bodies.card,
      text: text,
      onBackground: backgroundTap ? () {} : null,
      buttons: buttons,
    );

/// Shows card with given title and text
Future<String> showTitleText(
  BuildContext context,
  String title,
  String text, {
  Map<String, Color> buttons,
  bool backgroundTap = true,
}) =>
    show(
      context,
      Bodies.card,
      title: title,
      text: text,
      onBackground: backgroundTap ? () {} : null,
      buttons: buttons,
    );

/// Shows card with text and button yes no confirmation
Future<bool> showConfirm(
  BuildContext context,
  String title,
  String text,
) async {
  final String confirm = await show<String>(
    context,
    Bodies.card,
    title: title,
    text: text,
    buttons: <String, Color>{'Tak': AppColors.accent, 'Nie': AppColors.red},
  );
  return confirm == 'Tak';
}

/// Shows card with given custom Widget
Future<void> showCustom<T>(
  BuildContext context,
  Widget child, {
  String identifier,
  bool backgroundTap = true,
}) =>
    show(
      context,
      Bodies.card,
      identifier: identifier,
      child: child,
      onBackground: backgroundTap ? () {} : null,
    );

/// Shows card with selectable item list
Future<T> showItems<T>(
  BuildContext context,
  List<T> items,
  Widget Function(T) itemWidget, {
  String identifier,
  bool backgroundTap = false,
}) {
  return show<T>(
    context,
    Bodies.card,
    identifier: identifier,
    items: items,
    itemWidget: itemWidget,
    onBackground: backgroundTap ? () {} : null,
  );
}

/// Shows card with selectable item future list
Future<T> showItemsFuture<T>(
  BuildContext context,
  Future<List<T>> itemsFuture,
  Widget Function(T) itemWidget, {
  String identifier,
  bool backgroundTap = false,
}) {
  return show<T>(
    context,
    Bodies.card,
    identifier: identifier,
    itemsFuture: itemsFuture,
    itemWidget: itemWidget,
    onBackground: backgroundTap ? () {} : null,
  );
}

/// Shows error
Future<void> showError(
  BuildContext context,
  String text, {
  bool backgroundTap = true,
}) =>
    show(
      context,
      Bodies.card,
      text: text,
      color: AppColors.red,
      textStyle: TextStyle(
        fontSize: FontSizes.medium,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      onBackground: backgroundTap ? () {} : null,
    );

Future<void> showNotification(
  BuildContext context,
  String text, {
  bool backgroundTap = true,
}) =>
    show(
      context,
      Bodies.notification,
      text: text,
      color: AppColors.accent,
      textStyle: TextStyle(
        fontSize: FontSizes.medium,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      onBackground: backgroundTap ? () {} : null,
    );
// ############################################################################
Map<String, OverlayCubit> _entries = <String, OverlayCubit>{};

/// Shows overlay with given parameters
Future<T> show<T>(
  BuildContext context,
  Bodies body, {
  String identifier,
  String title,
  String text,
  TextStyle textStyle = const TextStyle(fontSize: FontSizes.medium, color: Colors.black),
  Widget child,
  Map<String, Color> buttons,
  Function onBackground,
  List<T> items,
  Future<List<T>> itemsFuture,
  Widget Function(T) itemWidget,
  Color color = Colors.white,
  double opacity = 0.33,
}) async {
  T result;
  try {
    final String key = identifier ?? Uuid().v4();
    final OverlayState state = Overlay.of(context);
    final OverlayCubit cubit = OverlayCubit();
    final OverlayEntry entry = OverlayEntry(
      builder: (BuildContext context) => BlocProvider(
        create: (BuildContext context) => cubit,
        child: OverlayBody<T>(
          body,
          color,
          (T item) => result = item,
          title,
          text,
          textStyle,
          child,
          buttons,
          items,
          itemsFuture,
          itemWidget,
          onBackground,
          max(0, min(opacity, 1.0)),
        ),
      ),
    );
    _entries.addAll(<String, OverlayCubit>{key: cubit});
    state.insert(entry);
    const Duration wait = Duration(milliseconds: 66);
    bool active = true;
    while (cubit.state != States.end) {
      await Future<T>.delayed(wait);
      if (cubit.state == States.init) {
        cubit.show();
      }
    }
    if (active) {
      entry.remove();
      _entries.remove(key);
      active = false;
    }
  } on Exception {
    result = null;
  }
  return result;
}

void hide(String identifier) {
  if (_entries.containsKey(identifier)) {
    _entries[identifier].hide();
    _entries.remove(identifier);
  }
}

bool hideLast() {
  if (_entries.isNotEmpty) {
    MapEntry<String, OverlayCubit> entry = _entries.entries.last;
    entry.value.hide();
    _entries.remove(entry.key);
    return true;
  }
  return false;
}

void hideAll() {
  _entries.forEach((key, value) {
    value?.hide();
  });
  _entries.clear();
}
// ############################################################################
