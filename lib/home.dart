//'http://192.168.100.26/mnjzphp/search/suggestion.php'

import 'package:flutter/material.dart';
import 'package:search_php_flutter/api_services.dart';
import 'package:search_php_flutter/data_model.dart';
import 'package:search_php_flutter/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FetchData _userList = FetchData();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Data List"),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchData());
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: Container(
          child: FutureBuilder<List<DataModel>>(
              future: _userList.getDataList(),
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
                                  Text("${data?[index].company}")
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }
}
