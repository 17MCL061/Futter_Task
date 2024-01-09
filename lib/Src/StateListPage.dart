import 'package:flutter/material.dart';
import 'package:fluttertask/Src/CityListPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StateListPage extends StatefulWidget {
  final String? userName;
  StateListPage({Key? key, this.userName}) : super(key: key);

  @override
  State<StateListPage> createState() => _StateListPageState();
}

class _StateListPageState extends State<StateListPage> {
  Future<List<dynamic>>? dataList;

  @override
  void initState() {
    super.initState();

    dataList = userList();
  }

  Future<List> userList() async {
    Uri getURL = Uri.parse('http://api.minebrat.com/api/v1/states');

    final response = await http.get(getURL);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('State List',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: dataList,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final List<dynamic> respModalList = snapshot.data!;

                  return ListView.builder(
                    itemCount: respModalList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CityListPage(
                                        userName: widget.userName,
                                        stateName: respModalList[index]
                                            ['stateName'],
                                        stateId: respModalList[index]
                                            ['stateId'],
                                      )));
                        },
                        child: Card(
                          elevation: 3.0,
                          margin: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 40,
                                padding: EdgeInsets.only(
                                    right: 10, top: 5, left: 10),
                                child: Text(
                                  respModalList[index]['stateName'],
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
