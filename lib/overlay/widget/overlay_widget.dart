import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/constants.dart';
import '../cubit/overlay_cubit.dart';

enum Bodies { card, notification, toast, intercept }

class OverlayBody<T> extends StatefulWidget {
  final Bodies? body;
  final Color? color;
  final double? opacity;
  final Function? onItem;
  final Function? onBackground;
  final String? title;
  final TextStyle? titleStyle;
  final String? text;
  final TextStyle? textStyle;
  final Widget? child;
  final Map<String, Color>? buttons;
  final List<T>? items;
  final Future<List<T>>? itemsFuture;
  final Widget Function(T)? itemWidget;
  final bool? close;

  bool? get gotButtons => buttons != null && buttons!.isNotEmpty;
  bool? get isBackground => onBackground != null;
  bool? get isChild => child != null;
  bool? get isTap => !(gotButtons! || isChild! || items != null || itemsFuture != null);

  OverlayBody(
    this.body,
    this.color,
    this.onItem,
    this.title,
    this.titleStyle,
    this.text,
    this.textStyle,
    this.child,
    this.buttons,
    this.items,
    this.itemsFuture,
    this.itemWidget,
    this.onBackground,
    this.opacity,
    this.close, {
    Key? key,
  }) : super(key: key);

  @override
  _OverlayBodyState<T> createState() => _OverlayBodyState<T>();
}

class _OverlayBodyState<T> extends State<OverlayBody<T>> with TickerProviderStateMixin {
  static const Duration duration = Duration(milliseconds: 200);
  AnimationController? controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: duration, vsync: this);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> show() async {
    controller?.forward();
    await Future.delayed(duration);
    OverlayCubit.of(context).idle();
  }

  Future<void> hide() async {
    controller?.reverse();
    await Future.delayed(duration);
    OverlayCubit.of(context).end();
  }

  void close(States state) {
    if (state == States.idle) {
      widget.onBackground?.call();
      OverlayCubit.of(context).hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocListener<OverlayCubit, States>(
        listener: (BuildContext context, States state) async {
          if (state == States.showing) {
            await show();
          } else if (state == States.hiding) {
            await hide();
          }
        },
        child: BlocBuilder<OverlayCubit, States>(
          builder: (BuildContext context, States state) {
            return Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      if (widget.onBackground != null) {
                        close(state);
                      }
                    },
                    child: FadeTransition(
                      opacity: Tween<double>(begin: 0, end: 1).animate(controller!),
                      child: Container(color: Colors.black.withOpacity(widget.opacity!)),
                    ),
                  ),
                ),
                if (widget.body == Bodies.notification)
                  Positioned(left: 0, right: 0, top: 0, child: body(state, -1))
                else if (widget.body == Bodies.card)
                  Positioned(left: 0, right: 0, bottom: 0, child: body(state, 1))
                else if (widget.body == Bodies.toast)
                  Positioned(
                    bottom: Edges.large * 5,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      alignment: Alignment.center,
                      child: FadeTransition(
                        opacity: Tween<double>(begin: 0, end: 1).animate(controller!),
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.color ?? Theme.of(context).dialogTheme.backgroundColor,
                            border: Border.all(color: Colors.grey.shade400, width: 2),
                            borderRadius: BorderRadius.circular(Edges.medium),
                          ),
                          child: text(),
                        ),
                      ),
                    ),
                  )
                else
                  Container()
              ],
            );
          },
        ),
      ),
    );
  }

  Widget body(States state, double direction) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double topPadding = mediaQuery.padding.top;
    final double maxHeight = mediaQuery.size.height * 0.75;
    return GestureDetector(
      onTap: () {
        if (widget.isTap! && state == States.idle) {
          OverlayCubit.of(context).hide();
        }
      },
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, direction),
          end: Offset(0, 0),
        ).animate(
          CurvedAnimation(
            curve: (state == States.showing ? Curves.easeOutQuad : Curves.easeInQuad),
            parent: controller!,
          ),
        ),
        child: Container(
          constraints: BoxConstraints(maxHeight: maxHeight),
          color: widget.color ?? Theme.of(context).dialogTheme.backgroundColor,
          padding: EdgeInsets.only(top: widget.body == Bodies.notification ? topPadding : 0.0),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    title(),
                    text(),
                    child(),
                    items(state, widget.items!),
                    itemsFuture(state),
                    buttons(state),
                  ],
                ),
                if (widget.close!)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        shape: CircleBorder(),
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => close(state),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget title() {
    if (widget.title != null && widget.title!.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.only(
          left: Edges.medium,
          right: Edges.medium,
          top: Edges.small,
        ),
        child: Text(
          widget.title!,
          style: Theme.of(context).dialogTheme.titleTextStyle,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget text() {
    if (widget.text != null && widget.text!.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Edges.large,
          vertical: Edges.medium,
        ),
        child: Text(
          widget.text!,
          style: widget.textStyle ?? Theme.of(context).dialogTheme.contentTextStyle,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget child() => widget.child ?? Container();

  Widget items(States state, List<T> items) {
    if (items != null && items.isNotEmpty && widget.itemWidget != null) {
      return Stack(
        children: [
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final T item = items[index];
              return Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () {
                    if (state == States.idle) {
                      widget.onItem?.call(item);
                      OverlayCubit.of(context).hide();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Builder(
                      builder: (context) {
                        try {
                          return widget.itemWidget!(item);
                        } catch (x) {
                          log(x.toString());
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    }
    return Container();
  }

  Widget itemsFuture(States state) {
    if (widget.itemsFuture != null) {
      return FutureBuilder(
        future: widget.itemsFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(Edges.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
              return items(state, snapshot.data);
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Edges.large,
                  vertical: Edges.medium,
                ),
                child: Text(snapshot.error! as String),
              );
            }
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Edges.large,
                vertical: Edges.medium,
              ),
              child: Text(
                'Błąd przetwarzania danych',
              ),
            );
          }
        },
      );
    } else {
      return Container();
    }
  }

  Widget buttons(States state) {
    if (widget.gotButtons!) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: Edges.small),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: widget.buttons!.entries.map(
            (MapEntry<String, Color> entry) {
              return TextButton(
                onPressed: () {
                  if (state == States.idle) {
                    widget.onItem?.call(entry.key);
                    OverlayCubit.of(context).hide();
                  }
                },
                child: Text(
                  entry.key,
                  style: Theme.of(context).textTheme.button!.copyWith(
                        color: entry.value,
                      ),
                ),
              );
            },
          ).toList(),
        ),
      );
    } else {
      return Container();
    }
  }
}
