import 'package:flutter/material.dart';
import 'package:fluttertask/Src/CityListPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CityListPage extends StatefulWidget {
  final String? userName;
  final String? stateName;
  final String? stateId;

  CityListPage({
    Key? key,
    this.userName,
    this.stateName,
    this.stateId,
  }) : super(key: key);

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  late Future<List<dynamic>>? dataList;
  int? id = 0;

  String cityName = "";

  @override
  void initState() {
    super.initState();
    dataList = userList();
  }

  Future<List> userList() async {
    Uri getURL = Uri.parse(
        'http://api.minebrat.com/api/v1/states/cities/${widget.stateId}');

    final response = await http.get(getURL);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('City List',
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
                          setState(() {
                            cityName = respModalList[index]['cityName'];
                          });

                          _showAlertDialog(context);
                        },
                        child: Card(
                          elevation: 3.0,
                          margin: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 40,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(
                                    right: 10, top: 5, left: 10),
                                child: Text(
                                  respModalList[index]['cityName'],
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

  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
              alignment: Alignment.center,
              child: Text(
                'UserDetails',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )),
          content: Container(
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text(
                  "UserName: " + widget.userName.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
                Text("State: " + widget.stateName.toString(),
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("City: " + cityName.toString(),
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          actions: [],
        );
      },
    );
  }
}
