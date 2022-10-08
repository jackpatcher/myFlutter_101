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
  /// LOCAL VAR
  final _searchController = TextEditingController();
  List<dynamic> stdAll = [];
  List<dynamic> stdAllShow = [];
 

  Future<List<dynamic>> _getStd() async {
    

    var url = cf.apiExe;

    try {
      var res = await http.get(Uri.parse(url));
      stdAll.clear();
       stdAllShow.clear();
      var json = conv.jsonDecode(res.body);

      for (var i in json) {
        stdAll.add(Std.fromJsonMap(i));
      }
    } catch (e) {
      print(e);
    }  

    stdAllShow.addAll(stdAll);

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
                    TextField(
                      controller: _searchController ,
                      onChanged:  searchText ,
                      decoration: InputDecoration(
                      labelText: 'ค้นหา',
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'ชื่อ  สกุล',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color:Colors.blue),
                      ),
                    ), 
                  ),
                  const SizedBox( height: 20,),
                  Expanded(
                      child:  ListView.builder(
                                  itemCount: stdAllShow.length,
                                  itemBuilder: (context, index) {
                                    final u = stdAllShow[index];
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(u.imgUrl),
                                        radius: 35,
                                      ),
                                      title: Text("${u.startName} ${u.firstName} ${u.lastName}"),
                                      subtitle: Text(
                                          "เลขที่ ${u.stdNo} ชั้น  ${u.classLv}/${u.room}"),
                                    );
                                  }),
                ),
                ],
              ))),
    );
  }

  void searchText(String query){
    final suggestions = stdAllShow.where((std) {
      
      final firstName = std.firstName.toLowerCase();
      final lastName = std.lastName.toLowerCase();
      final text2Search = firstName + lastName;
      final input = query.toLowerCase();

      return text2Search.contains(input)   ;
      
    }).toList();

    setState(() {
      stdAllShow.clear();

      if(query != "") {
        stdAllShow = suggestions;
      } else {
        stdAllShow.addAll(stdAll);
      }

     
      
      });

  }
}
