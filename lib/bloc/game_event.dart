import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {}

class Fetch extends GameEvent {
  @override
  String toString() => 'Fetch';
}