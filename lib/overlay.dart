import 'package:flutter/material.dart';
import 'package:shared/utils/constants.dart';

enum _OverlayTypes {
  bottomText,
  bottomItems,
  bottomFutureItems,
  bottomTextField,
  bottomConfirm,
  intercept,
  topText,
  dialog,
}
enum Durations { none, short, medium, long }

Map<String, OverlayEntry> _entries = <String, OverlayEntry>{};

Future<void> showDialog({
  @required BuildContext context,
  @required String title,
  @required String text,
}) {
  return _show<String>(
    context: context,
    type: _OverlayTypes.dialog,
    backgroundOpacity: 64,
    title: title,
    text: text,
    buttons: <String, Color>{'ok': AppColors.accent},
  );
}

Future<void> showDialogConfirm({
  @required BuildContext context,
  @required String title,
  @required String text,
  @required Function(String) action,
}) {
  return _show<String>(
    context: context,
    type: _OverlayTypes.dialog,
    backgroundOpacity: 64,
    onSelectedItem: action,
    title: title,
    text: text,
    buttons: <String, Color>{
      'tak': AppColors.accent,
      'nie': AppColors.red,
    },
  );
}

Future<void> showBottomText({
  @required BuildContext context,
  @required String text,
  Durations duration = Durations.none,
  bool backgroundTap = true,
}) {
  return _show(
    context: context,
    type: _OverlayTypes.bottomText,
    text: text,
    duration: _duration(duration: duration),
    backgroundOpacity: 64,
    onBackgroundTap: backgroundTap ? () {} : null,
  );
}

Future<void> showNotification({
  @required BuildContext context,
  @required String text,
  Durations duration = Durations.none,
}) {
  return _show(
    context: context,
    type: _OverlayTypes.topText,
    text: text,
    textStyle: TextStyle(
      fontSize: FontSizes.medium,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    color: AppColors.accent,
    duration: _duration(duration: duration),
    backgroundOpacity: 0,
    onBackgroundTap: () {},
  );
}

Future<void> showError({
  @required BuildContext context,
  @required String text,
  Durations duration = Durations.none,
  bool backgroundTap = true,
}) {
  return _show(
    context: context,
    type: _OverlayTypes.bottomText,
    text: text,
    textStyle: TextStyle(
      fontSize: FontSizes.medium,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    color: Colors.red,
    duration: _duration(duration: duration),
    backgroundOpacity: 64,
    onBackgroundTap: backgroundTap ? () {} : null,
  );
}

Future<void> showBottomItems<T>({
  @required BuildContext context,
  @required List<T> items,
  @required Function(T) itemWidget,
  Function(T) onSelectedItem,
  bool backgroundTap = true,
}) {
  assert(items != null && items.isNotEmpty);
  return _show<T>(
    context: context,
    type: _OverlayTypes.bottomItems,
    items: items,
    itemWidget: itemWidget,
    onSelectedItem: onSelectedItem,
    backgroundOpacity: 64,
    onBackgroundTap: backgroundTap ? () {} : null,
  );
}

Future<void> showBottomFutureItems<T>({
  @required BuildContext context,
  @required Future<List<T>> itemsFuture,
  @required Widget Function(T) itemWidget,
  Function(T) onSelectedItem,
  bool backgroundTap = true,
}) {
  return _show<T>(
    context: context,
    type: _OverlayTypes.bottomFutureItems,
    itemsFuture: itemsFuture,
    itemWidget: itemWidget,
    onSelectedItem: onSelectedItem,
    backgroundOpacity: 64,
    onBackgroundTap: backgroundTap ? () {} : null,
  );
}

Future<void> showBottomTextField({
  @required BuildContext context,
  @required Function(String) onSubmitt,
  String value = '',
  String hintText = '',
  bool backgroundTap = true,
}) {
  return _show(
    context: context,
    type: _OverlayTypes.bottomTextField,
    onSubmitt: onSubmitt,
    hint: hintText,
    text: value,
    backgroundOpacity: 64,
    onBackgroundTap: backgroundTap ? () {} : null,
  );
}

Future<void> showBottomConfirm({
  @required BuildContext context,
  @required String title,
  @required String text,
  @required Function(String) action,
}) {
  return _show<String>(
    context: context,
    type: _OverlayTypes.bottomConfirm,
    backgroundOpacity: 64,
    onSelectedItem: action,
    title: title,
    text: text,
    buttons: <String, Color>{
      'tak': AppColors.accent,
      'nie': AppColors.red,
    },
  );
}

Future<void> intercept({
  @required BuildContext context,
  String identifier,
  FocusNode focusNode,
}) {
  return _show(
    context: context,
    type: _OverlayTypes.intercept,
    backgroundOpacity: 0,
    onBackgroundTap: () => FocusScope.of(context).unfocus(),
    identifier: identifier,
  );
}

void hide({@required String identifier}) {
  if (_entries.containsKey(identifier)) {
    _entries[identifier].remove();
    _entries.remove(identifier);
  }
}

void _entryRemove({OverlayEntry entry, String identifier}) {
  if (_entries.containsKey(identifier)) {
    assert(entry == _entries[identifier]);
    _entries.remove(identifier);
  }
  entry.remove();
}

Duration _duration({@required Durations duration}) {
  switch (duration) {
    case Durations.short:
      return const Duration(milliseconds: 1000);
    case Durations.medium:
      return const Duration(milliseconds: 2000);
    case Durations.long:
      return const Duration(milliseconds: 3000);
    case Durations.none:
    default:
      return Duration.zero;
  }
}

Future<T> _show<T>({
  @required BuildContext context,
  @required _OverlayTypes type,
  @required int backgroundOpacity,
  String identifier,
  String title,
  String text,
  TextStyle textStyle,
  String hint,
  List<T> items,
  Future<List<T>> itemsFuture,
  Widget Function(T) itemWidget,
  Widget dialog,
  Function(T) onSelectedItem,
  Function onBackgroundTap,
  Function(String) onSubmitt,
  Duration duration = Duration.zero,
  Color color = Colors.white,
  Map<String, Color> buttons,
}) async {
  T result;
  final OverlayState state = Overlay.of(context);
  OverlayEntry entry;
  _Overlay<T> overlay;
  bool removed = false;
  overlay = _Overlay<T>(
    type: type,
    title: title,
    text: text,
    textStyle: textStyle ?? const TextStyle(fontSize: FontSizes.medium, color: Colors.black),
    hint: hint,
    items: items,
    itemsFuture: itemsFuture,
    itemWidget: itemWidget,
    dialog: dialog,
    color: color,
    buttons: buttons,
    backgroundOpacity: backgroundOpacity,
    onBackgroundTap: onBackgroundTap != null
        ? () async {
            if (onBackgroundTap != null) {
              onBackgroundTap.call();
              result = null;
              if (!removed) {
                _entryRemove(entry: entry, identifier: identifier);
                removed = true;
              }
            }
          }
        : null,
    onSelectedItem: (T item) async {
      result = item;
      onSelectedItem?.call(item);
      if (!removed) {
        _entryRemove(entry: entry, identifier: identifier);
        removed = true;
      }
    },
    onSubmitt: (String data) async {
      result = null;
      onSubmitt?.call(data);
      if (!removed) {
        _entryRemove(entry: entry, identifier: identifier);
        removed = true;
      }
    },
  );
  entry = OverlayEntry(builder: (BuildContext context) => overlay);
  if (identifier != null) {
    _entries.addAll(<String, OverlayEntry>{identifier: entry});
  }
  state.insert(entry);
  if (duration != Duration.zero) {
    await Future<void>.delayed(_OverlayState.duration + duration);
    await overlay.hide();
    if (!removed) {
      _entryRemove(entry: entry, identifier: identifier);
      removed = true;
    }
  }
  return result;
}

class _Overlay<T> extends StatefulWidget {
  final _OverlayTypes type;
  final String title;
  final String text;
  final TextStyle textStyle;
  final String hint;
  final List<T> items;
  final Future<List<T>> itemsFuture;
  final Widget Function(T) itemWidget;
  final Widget dialog;
  final int backgroundOpacity;
  final Function onBackgroundTap;
  final Function onSelectedItem;
  final Function(String) onSubmitt;
  final Color color;
  final Map<String, Color> buttons;

  final _OverlayState<T> state = _OverlayState<T>();

  _Overlay({
    @required this.type,
    this.title,
    this.text,
    this.textStyle,
    this.hint,
    this.items,
    this.itemsFuture,
    this.itemWidget,
    this.dialog,
    this.backgroundOpacity,
    this.onBackgroundTap,
    this.onSelectedItem,
    this.onSubmitt,
    this.color,
    this.buttons,
    Key key,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _OverlayState<T> createState() => state;

  Future<void> hide() => state.hide();
}

class _OverlayState<T> extends State<_Overlay<T>> with TickerProviderStateMixin {
  static const Duration duration = Duration(milliseconds: 180);

  TextEditingController inputController;
  AnimationController fadeInController;
  AnimationController fadeOutCotroller;
  AnimationController slideInController;
  AnimationController slideOutController;
  Animation fadeInAnimation;
  Animation fadeOutAnimation;
  Animation slideInAnimation;
  Animation slideOutAnimation;

  bool direction = true;

  @override
  void initState() {
    super.initState();
    bool bottom = widget.type != _OverlayTypes.topText;
    inputController = TextEditingController(text: widget.text ?? '');
    fadeInController = AnimationController(duration: duration, vsync: this)..forward();
    fadeOutCotroller = AnimationController(duration: duration, vsync: this);
    slideInController = AnimationController(duration: duration, vsync: this)..forward();
    slideOutController = AnimationController(duration: duration, vsync: this);
    fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: fadeInController,
      curve: Curves.easeOutQuad,
    ));
    fadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: fadeOutCotroller,
      curve: Curves.easeInQuad,
    ));
    slideInAnimation = Tween<Offset>(
      begin: bottom ? const Offset(0.0, 1.0) : const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: fadeInController,
      curve: bottom ? Curves.easeOutCubic : Curves.easeOutQuad,
    ));
    slideOutAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: bottom ? const Offset(0.0, 1.0) : const Offset(0.0, -1.0),
    ).animate(CurvedAnimation(
      parent: fadeOutCotroller,
      curve: bottom ? Curves.easeInCubic : Curves.easeInQuad,
    ));
  }

  @override
  void dispose() {
    inputController.dispose();
    fadeInController.dispose();
    fadeOutCotroller.dispose();
    slideInController.dispose();
    slideOutController.dispose();
    super.dispose();
  }

  Future<void> hide() async {
    if (mounted) {
      setState(() => direction = false);
      await Future.wait([fadeOutCotroller.forward(), slideOutController.forward()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned.fill(
              child: GestureDetector(
                onTap: () async {
                  if (widget.onBackgroundTap != null) {
                    await hide();
                    widget.onBackgroundTap?.call();
                  }
                },
                child: FadeTransition(
                  opacity: direction ? fadeInAnimation : fadeOutAnimation,
                  child: Container(
                    color: Colors.black.withAlpha(widget.backgroundOpacity),
                  ),
                ),
              ),
            ),
            if (widget.type == _OverlayTypes.intercept)
              Container()
            else if (widget.type == _OverlayTypes.topText)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: innerBodySlide(),
              )
            else if (widget.type == _OverlayTypes.dialog)
              Positioned(
                left: 0,
                right: 0,
                child: innerBodyFade(),
              )
            else
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: innerBodySlide(),
              ),
          ],
        ),
      ),
    );
  }

  Widget innerBodySlide() {
    return SlideTransition(
      position: direction ? slideInAnimation : slideOutAnimation,
      child: Container(
        color: widget.color,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        child: typeWidget(context, widget.type),
      ),
    );
  }

  Widget innerBodyFade() {
    return SlideTransition(
      position: direction ? slideInAnimation : slideOutAnimation,
      child: FadeTransition(
        opacity: direction ? fadeInAnimation : fadeOutAnimation,
        child: Container(
          color: widget.color,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          child: typeWidget(context, widget.type),
        ),
      ),
    );
  }

  Widget typeWidget(BuildContext context, _OverlayTypes type) {
    switch (type) {
      case _OverlayTypes.topText:
      case _OverlayTypes.bottomText:
        return text();
      case _OverlayTypes.bottomItems:
        return items(widget.items);
      case _OverlayTypes.bottomFutureItems:
        return itemsFuture();
      case _OverlayTypes.bottomTextField:
        return bottomTextField(context);
      case _OverlayTypes.bottomConfirm:
        return dialog();
      case _OverlayTypes.dialog:
        return dialog();
      default:
        return Container(
          padding: const EdgeInsets.all(Edges.large),
          child: Text('overlay type not recognized: $type'),
        );
    }
  }

  Widget text() {
    assert(widget.text != null && widget.text.isNotEmpty);
    return Padding(
      padding: const EdgeInsets.all(Edges.medium),
      child: Text(widget.text, style: widget.textStyle),
    );
  }

  Widget items(List<T> items) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final T item = items[index];
        return Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () async {
              await hide();
              widget.onSelectedItem?.call(item);
            },
            child: Container(
              alignment: Alignment.center,
              child: widget.itemWidget(item),
            ),
          ),
        );
      },
    );
  }

  Widget itemsFuture() {
    return FutureBuilder(
      future: widget.itemsFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: const EdgeInsets.all(Edges.medium),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                ),
              ],
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return items(snapshot.data);
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Edges.large, vertical: Edges.medium),
              child: Text(
                snapshot.error,
                style: TextStyle(fontSize: FontSizes.medium),
              ),
            );
          }
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Edges.large, vertical: Edges.medium),
            child: Text(
              'Błąd przetwarzania danych',
              style: TextStyle(fontSize: FontSizes.medium),
            ),
          );
        }
      },
    );
  }

  Widget bottomTextField(BuildContext context) {
    assert(widget.onSubmitt != null);
    return Padding(
      padding: const EdgeInsets.all(Edges.verySmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: Edges.small),
                  child: TextField(
                    autofocus: true,
                    controller: inputController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (String data) async {
                      await hide();
                      widget.onSubmitt?.call(data);
                    },
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: TextStyle(fontSize: FontSizes.medium, color: Colors.grey.shade500),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                  // TODO introduce TextFormField and add validator to constructor
                ),
              ),
              Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => inputController.clear(),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: const Icon(Icons.done),
                  onPressed: () async {
                    await hide();
                    widget.onSubmitt?.call(inputController.text);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget dialog() {
    return Material(
      elevation: 5,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Edges.medium, vertical: Edges.small),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: FontSizes.large,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: Edges.large,
                right: Edges.large,
                bottom: Edges.small,
              ),
              child: Text(
                widget.text,
                style: TextStyle(fontSize: FontSizes.medium),
              ),
            ),
            buttons(),
          ],
        ),
      ),
    );
  }

  Widget buttons() {
    assert(widget.buttons != null);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: widget.buttons.entries
          .map(
            (MapEntry<String, Color> entry) => button(
              text: entry.key,
              color: entry.value ?? AppColors.accent,
            ),
          )
          .toList(),
    );
  }

  Widget button({String text, Color color}) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () async {
          await hide();
          widget.onSelectedItem?.call(text);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Edges.large,
            vertical: Edges.small,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: FontSizes.medium,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
