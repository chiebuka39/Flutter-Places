import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:places_finder/events/autocomplete_event.dart';
import 'package:places_finder/repository/places_prediction_repository.dart';
import 'package:places_finder/states/auto_complete_states.dart';
import 'package:rxdart/rxdart.dart';

class AutoCompleteBloc extends Bloc<AutoCompleteEvent, AutoCompleteState> {
  final PlacesPredictionRepository repository;

  AutoCompleteBloc({@required this.repository});



  @override
  Stream<AutoCompleteEvent> transform(Stream<AutoCompleteEvent> events) {
    return (events as Observable<AutoCompleteEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  void onTransition(
      Transition<AutoCompleteEvent, AutoCompleteState> transition) {
    print(transition.toString());
  }

  @override
  AutoCompleteState get initialState => AutoCompleteStateEmpty();

  @override
  Stream<AutoCompleteState> mapEventToState(AutoCompleteState state,
      AutoCompleteEvent event,
      ) async* {
    if (event is TextChanged) {
      final String searchTerm = event.text;
      if (searchTerm.isEmpty) {
        yield AutoCompleteStateEmpty();
      } else {
        yield AutoCompleteLoading();
        try {
          final results = await repository.getPredictions(searchTerm);
          yield AutoCompleteSuccess(results);
        } catch (error) {
          yield error is AutoCompleteError
              ? AutoCompleteError(error.error)
              : AutoCompleteError('something went wrong');
        }
      }
    }
  }
}