import 'package:flutter/material.dart';
import 'package:places_finder/models/place_prediction.dart';
import 'package:places_finder/repository/place_details_repository.dart';
import 'package:places_finder/ui/place_details_ui.dart';

class SearchResults extends StatelessWidget {
  final List<PredictedPlace> items;
  final PlaceDetailsRepository repository;


  const SearchResults({Key key, this.items, this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return _SearchResultItem(item: items[index], repository: repository,);
      },
    );
  }
}


class _SearchResultItem extends StatelessWidget {
  final PredictedPlace item;
  final PlaceDetailsRepository repository;

  const _SearchResultItem({Key key, @required this.item, this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.title),
      ),
      title: Text(item.description),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlacesDetailsMap(
            detailsRepository:repository,
            placeId: item.placeId,
          )),
        );
        print(item.description);
      },
    );
  }
}