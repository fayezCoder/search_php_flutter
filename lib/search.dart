import 'package:flutter/material.dart';
import 'package:search_php_flutter/api_services.dart';
import 'package:search_php_flutter/data_model.dart';

class SearchData extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  final FetchData _userList = FetchData();

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: FutureBuilder<List<DataModel>>(
          future: _userList.getDataList(query:query),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text("${data?[index].id}"),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                "${data?[index].name}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("${data?[index].email}")
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text("Search Data"),
    );
  }
}
