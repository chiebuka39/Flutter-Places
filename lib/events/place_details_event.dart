import 'package:equatable/equatable.dart';

abstract class PlaceDetailsEvent extends Equatable{
  PlaceDetailsEvent([List props = const []]) : super(props);
}

class PlaceIdSent extends PlaceDetailsEvent{
  final String text;

  PlaceIdSent({this.text}): super([text]);

  @override
  String toString() => 'Place Id sent';
}