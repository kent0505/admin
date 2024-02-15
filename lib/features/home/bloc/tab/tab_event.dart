part of 'tab_bloc.dart';

abstract class TabEvent {}

class ChangeTabEvent extends TabEvent {
  final int index;
  ChangeTabEvent(this.index);
}
