import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsheet2/models/std.dart';
import 'package:gsheet2/services/gsheet.dart';
import 'package:gsheet2/ui/app.dart';

class HomePage extends StatefulWidget {
  final GoogleSheetsProvider provider;
  const HomePage({
    required this.provider,
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Std>> get stds => widget.provider.getStd();
  

  @override
  Widget build(BuildContext context) {
  
  


    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Demo'),
      ),
      body: FutureBuilder<List<Std>>(
        future: stds,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final stds = snapshot.data!;
            print(stds.length);

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView.builder(
                itemCount: stds.length,
                itemBuilder: (context, index) => StdCard(
                      firstName: stds[index].firstName,
                      lastName: stds[index].lastName,
                      onDelete: () async {
                        await widget.provider.deleteStd(index);

                        /// should call again the getter
                        setState(() {});
                      },
                    )),
          );
        },
      ),
     

        floatingActionButton: Fab(),
 
    );
  }
}

class Fab extends StatelessWidget {
  const Fab({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
              FloatingActionButton(
                onPressed: () async {
                  await Navigator.of(context).pushNamed(routeDt1);
                },
                child: const Icon(
                  CupertinoIcons.table,
                  color: Colors.white,
                ),
              ) , FloatingActionButton(
                onPressed: () async {
                  await Navigator.of(context).pushNamed(routeAdd);
                },
                child: const Icon(
                  CupertinoIcons.plus,
                  color: Colors.white,
                ),
              ) 

      ],
    );



     ;
  }
}

class StdCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final VoidCallback onDelete;

  const StdCard({
    required this.firstName,
    required this.lastName,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    firstName,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Text(lastName, textAlign: TextAlign.start),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                color: Colors.grey,
                height: 20.0,
                width: 2.0,
              ),
            ),
            Center(
              child: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}