import 'package:equatable/equatable.dart';

abstract class AutoCompleteEvent extends Equatable{
  AutoCompleteEvent([List props = const []]) : super(props);
}

class TextChanged extends AutoCompleteEvent{
  final String text;

  TextChanged({this.text}): super([text]);

  @override
  String toString() => 'Text Changed';
}