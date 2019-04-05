import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:places_finder/events/place_details_event.dart';
import 'package:places_finder/repository/place_details_repository.dart';
import 'package:places_finder/states/place_details_states.dart';
import 'package:rxdart/rxdart.dart';

class PlaceDetailsBloc extends Bloc<PlaceDetailsEvent, PlaceDetailsState> {
  final PlaceDetailsRepository repository;

  PlaceDetailsBloc({@required this.repository});



  @override
  Stream<PlaceDetailsEvent> transform(Stream<PlaceDetailsEvent> events) {
    return (events as Observable<PlaceDetailsEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  void onTransition(
      Transition<PlaceDetailsEvent, PlaceDetailsState> transition) {
    print(transition.toString());
  }

  @override
  PlaceDetailsState get initialState => PlaceDetailsStateEmpty();

  @override
  Stream<PlaceDetailsState> mapEventToState(PlaceDetailsState state,
      PlaceDetailsEvent event,
      ) async* {
    if (event is PlaceIdSent) {
      final String searchTerm = event.text;
      print(searchTerm);
      if (searchTerm.isEmpty) {
        yield PlaceDetailsStateEmpty();
      } else {
        yield PlaceDetailsLoading();
        try {
          final results = await repository.getDetails(searchTerm);
          yield PlaceDetailsSuccess(results);
        } catch (error) {
          yield error is PlaceDetailsError
              ? PlaceDetailsError(error.error)
              : PlaceDetailsError('something went wrong');
        }
      }
    }
  }
}