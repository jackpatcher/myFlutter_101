import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

 
/// Widget for the root/initial pages in the bottom navigation bar.
class RootScreen extends StatefulWidget {


  /// Creates a RootScreen
  const RootScreen({required this.label, required this.detailsPath, Key? key, required this.index,})
      : super(key: key);

  /// The label
  final String label;
  final int index;
  /// The path to the detail pge
  final String detailsPath;

 

  
  @override
  State<RootScreen>  createState() => _RootScreenState();

}

class _RootScreenState  extends State<RootScreen>{
     
 
   
  @override
  Widget build(BuildContext context) {
  debugPrint("test2 - rooScreen tabIndex = ${widget.index}");


    return Scaffold(
      appBar: AppBar(
        title: Text('Tab root - ${widget.label}'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Screen  ${widget.label}',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            ElevatedButton(
              onPressed: () => context.go(widget.detailsPath),
              child: const Text('View details'),
            ),
          ],
        ),
      ),
     // bottomNavigationBar: ,
    );
  }


}

 
/// The details screen for either the A or B screen.
class DetailsScreen extends StatefulWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    Key? key,
  }) : super(key: key);

  /// The label to display in the center of the screen.
  final String label;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

/// The state for DetailsScreen
class _DetailsScreenState extends State<DetailsScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen - ${widget.label}'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Details for ${widget.label} - Counter: $_counter',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('+'),
            ),
          ],
        ),
      ),
    );
  }
}


 