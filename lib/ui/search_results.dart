import 'package:flutter/material.dart';
import 'package:places_finder/models/place_prediction.dart';

class SearchResults extends StatelessWidget {
  final List<PredictedPlace> items;

  const SearchResults({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return _SearchResultItem(item: items[index]);
      },
    );
  }
}


class _SearchResultItem extends StatelessWidget {
  final PredictedPlace item;

  const _SearchResultItem({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.title),
      ),
      title: Text(item.description),
      onTap: () {
        print(item.description);
      },
    );
  }
}