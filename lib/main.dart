import 'dart:async';
import 'dart:convert';
import 'package:flutter_api1/model_std.dart';
import 'package:flutter_api1/secret/config.dart' as cf;


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
 


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {  
   List<dynamic>   data = [];
   
      
   Future  <List<dynamic>>   _getStd()   async {

     var client = http.Client();
     
      var url = cf.apiExe;
       
 
 
     try {

        var  res =  await http.get(Uri.parse(url));
         data.clear();
        var json = jsonDecode(res.body );

        for(var i in json){
          data.add( Std.fromJsonMap(i));
        }

       
     } catch (e){
        print(e);

     }
     finally{
      client.close();
     }
      
 

    
 
     return  data;
    }

   @override
      void initState(){
      super.initState();

       _getStd();

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
        body: FutureBuilder (
          future: _getStd(),
          builder: (context, snapshot) {

            if(!snapshot.hasData) {
              return(const Center(child: CircularProgressIndicator(),));
            }
            else{      
             return  ListView.builder(
              itemCount: data.length,
               itemBuilder: (context,index) { 

                final item = snapshot.data![index];

                 return ListTile(
                  title: Text(item.firstName)
                 );
                  
           
              }

    
             );
            }
            }
            )

      ),
    );
  }
  

}

