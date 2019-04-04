import 'package:equatable/equatable.dart';
import 'package:places_finder/models/place_prediction.dart';

abstract class AutoCompleteState extends Equatable{
  AutoCompleteState([List props = const []]) : super(props);
}

class AutoCompleteStateEmpty extends AutoCompleteState {
  @override
  String toString() => 'SearchStateEmpty';
}

class AutoCompleteLoading extends AutoCompleteState {
  @override
  String toString() => 'SearchStateLoading';
}

class AutoCompleteSuccess extends AutoCompleteState {
  final PlacesPrediction prediction;

  AutoCompleteSuccess(this.prediction) : super([prediction]);

  @override
  String toString() => 'SearchStateSuccess { items: ${prediction} }';
}

class AutoCompleteError extends AutoCompleteState {
  final String error;

  AutoCompleteError(this.error) : super([error]);

  @override
  String toString() => 'SearchStateError';
}