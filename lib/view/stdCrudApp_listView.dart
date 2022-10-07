//https://www.youtube.com/watch?v=ZHdg2kfKmjI fliter search
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
  List<dynamic> stdAll = [];
 

  Future<List<dynamic>> _getStd() async {
    var client = http.Client();

    var url = cf.apiExe;

    try {
      var res = await http.get(Uri.parse(url));
      stdAll.clear();
      var json = conv.jsonDecode(res.body);

      for (var i in json) {
        stdAll.add(Std.fromJsonMap(i));
      }
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }

    return stdAll;
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
            title: const Text('นักเรียนทั้งหมด'),
          ),
          body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox( height: 10,),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'ค้นหา',suffixIcon: Icon(Icons.search)
                    ), 
                  ),
                  const SizedBox( height: 20,),
                  Expanded(
                      child: FutureBuilder(
                          future: _getStd(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return (const Center(
                                child: CircularProgressIndicator(),
                              ));
                            } else {
                              return ListView.builder(
                                  itemCount: stdAll.length,
                                  itemBuilder: (context, index) {
                                    final u = snapshot.data![index];

                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(u.imgUrl),
                                      ),
                                      title: Text("${u.startName} ${u.firstName} ${u.lastName}"),
                                      subtitle: Text(
                                          "เลขที่ ${u.stdNo} ชั้น  ${u.classLv}/${u.room}"),
                                    );
                                  });
                            }
                          })),
                ],
              ))),
    );
  }
}
