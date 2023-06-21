import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var jsonList;

  @override
  void initState() {
    getData();
  }

  void getData() async {
    try {
      var response = await Dio().get('https://picsum.photos/v2/list');
      if (response.statusCode == 200) {
        setState(() {
          jsonList = response.data as List;
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fake',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            elevation: 10,
            child: CarouselSlider.builder(
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                autoPlay: true,
                scrollDirection: Axis.horizontal,
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              itemCount: jsonList.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Container(
                child: Image.network(
                  "${jsonList[itemIndex]["download_url"]}",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: jsonList == null ? 0 : jsonList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: ListTile(
                      leading: Image.network(
                        jsonList[index]['download_url'],
                        fit: BoxFit.fill,
                        // width: 50,
                        // height: 50,
                      ),
                      title: Text(jsonList[index]['author']),
                      subtitle: Text(jsonList[index]['width'].toString()),
                      trailing: OutlinedButton(
                          onPressed: () async {
                            // final Uri url = Uri.parse(jsonList[index]['url']);
                            // if (!await launchUrl(url)) {
                            // throw Exception('Could not launch $_url');
                            // }

                            final Uri url = Uri.parse(jsonList[index]['url']);

                            // var url = "${jsonList[index]['url']}";
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              print("can't open");
                            }
                          },
                          child: Text("Download")),
                    ));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
