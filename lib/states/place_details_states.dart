import 'package:equatable/equatable.dart';
import 'package:places_finder/models/place_details.dart';

abstract class PlaceDetailsState extends Equatable{
  PlaceDetailsState([List props = const []]) : super(props);
}

class PlaceDetailsStateEmpty extends PlaceDetailsState {
  @override
  String toString() => 'SearchStateEmpty';
}

class PlaceDetailsLoading extends PlaceDetailsState {
  @override
  String toString() => 'SearchStateLoading';
}

class PlaceDetailsSuccess extends PlaceDetailsState {
  final PlaceDetailsData details;

  PlaceDetailsSuccess(this.details) : super([details]);

  @override
  String toString() => 'SearchStateSuccess { items: ${details} }';
}

class PlaceDetailsError extends PlaceDetailsState {
  final String error;

  PlaceDetailsError(this.error) : super([error]);

  @override
  String toString() => 'SearchStateError';
}