import 'package:ev_bul/models/animals.dart';
import 'package:flutter/material.dart';

class HomeSearchDelegate extends SearchDelegate<Animal?> {
  HomeSearchDelegate(this.tagItems);

  final List<Animal> tagItems;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('a');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final result = tagItems.where(
      (element) =>
          element.subtitle?.toLowerCase().contains(query.toLowerCase()) ??
          false,
    );
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            onTap: () {
              close(context, result.elementAt(index));
            },
            title: Text(result.elementAt(index).subtitle ?? ''),
          ),
        );
      },
    );
  }
}
