import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum States { init, showing, idle, hiding, end }

class OverlayCubit extends Cubit<States> {
  OverlayCubit() : super(States.init);

  static OverlayCubit of(BuildContext context) => context.read<OverlayCubit>();

  void show() => emit(States.showing);
  void hide() => emit(States.hiding);
  void idle() => emit(States.idle);
  void end() => emit(States.end);

  @override
  String toString() => 'OverlayCubit.$state';
}
