import 'dart:async';
import 'dart:convert';

/**
 * https://docs.google.com/spreadsheets/d/1bxbwoHlIrg6i99zWseb-CIJ7YfNR5bDdNmsqKFPLa10/edit#gid=0 script
 */
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://script.google.com/a/macros/smv.ac.th/s/AKfycbwaCoL5P--w9ftxhNLFMK8oJchtwWyeCBuIgip6M4GO20DVJ7tCqdNXsBFuEOLqLJ7y8w/exec?e=dfdf'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    print(jsonDecode(response.body)[1]);
     
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String userId;
  final String id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

 
  factory Album.fromJson( Map<String, dynamic>   json) {
    

    return Album(
      userId: json['stdId'],
      id: json['firstName'],
      title: json['lastName'],
    );
  }
} 

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum; 

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title.toString());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}