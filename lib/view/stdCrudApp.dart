import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_api1/model/std.dart';
import 'dart:convert' as conv;
import 'package:flutter_api1/secret/config.dart' as cf;
import 'package:http/http.dart' as http;

void main() => runApp(const StdCrudApp());

class StdCrudApp extends StatefulWidget {
  const StdCrudApp({super.key});
 
  @override
  State<StdCrudApp> createState() => _StdCrudAppState();
}

class _StdCrudAppState extends State<StdCrudApp> {
  List<dynamic> data = [];

  Future<List<dynamic>> _getStd() async {
    var client = http.Client();

    var url = cf.apiExe;

    try {
      var res = await http.get(Uri.parse(url));
      data.clear();
      var json = conv.jsonDecode(res.body);

      for (var i in json) {
        data.add(Std.fromJsonMap(i));
      }
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    return data;
  }

  @override
  void initState() {
    super.initState();

    _getStd();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch STD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Fetch Data STD'),
          ),
          body: FutureBuilder(
              future: _getStd(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return (const Center(
                    child: CircularProgressIndicator(),
                  ));
                } else {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final u = snapshot.data![index];

                        return ListTile(
                          leading: CircleAvatar(backgroundImage: NetworkImage(u.imgUrl), ),
                          title: Text(u.startName+" "+u.firstName+" "+ u.lastName)
                          );
                      });
                }
              })),
    );
  }
}
