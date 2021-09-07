import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/user_model.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("User Info"),
        ),
        body: Container(
          //height: 300,
          child: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text("No Connection");

                case ConnectionState.waiting:
                case ConnectionState.active:
                  return CircularProgressIndicator();

                case ConnectionState.done:
                  if (snapshot.data != null) {
                    return ListView.builder(
                      //scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.blueGrey[400],
                          //  height: 50,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 4.0),
                            child: Card(
                              // semanticContainer: true,
                              //clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 5,
                              color: Colors.grey,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      //Left Side Collumn
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.info,
                                              color: Colors.white,
                                              size: 18.0,
                                            ),
                                            SizedBox(
                                              width: 4.0,
                                            ),
                                            Text(
                                              "Id :" +
                                                  snapshot.data[index].id
                                                      .toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person_pin,
                                              color: Colors.white,
                                              size: 18.0,
                                            ),
                                            SizedBox(
                                              width: 4.0,
                                            ),
                                            Text(
                                              "Name :" +
                                                  snapshot.data[index].name
                                                      .toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 18.0,
                                            ),
                                            SizedBox(
                                              width: 4.0,
                                            ),
                                            Text(
                                              "User Name :" +
                                                  snapshot.data[index].username
                                                      .toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.email_rounded,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 4.0,
                                            ),
                                            Text(
                                              "Email Id : " +
                                                  snapshot.data[index].email
                                                      .toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_sharp,
                                              color: Colors.white,
                                              size: 18.0,
                                            ),
                                            SizedBox(
                                              width: 4.0,
                                            ),
                                            Text(
                                              "Location :",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 24.0,
                                            ),
                                            Text(
                                              snapshot.data[index].address.suite
                                                      .toString() +
                                                  " " +
                                                  snapshot.data[index].address
                                                      .street
                                                      .toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Text("Data is Not Loaded !");
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<List<UserModel>> getData() async {
  var url =
      Uri.parse("https://jsonplaceholder.typicode.com/users"); //url of api

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse.toString());
    Iterable list = jsonResponse;
    return list.map((singlearray) => UserModel.fromJson(singlearray)).toList();
  } else {
    print("Fetch data fail");
    throw Exception("Failed!");
  }
}
