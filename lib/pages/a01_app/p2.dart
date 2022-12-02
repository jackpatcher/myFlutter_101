import 'package:flutter/material.dart';
import '../theme.dart';



class Page2 extends StatefulWidget {
  final String title;

  const Page2({
    super.key,
    required this.title,
  });

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30.0), // here the desired height
          child: AppBar (
            elevation: 1,
        backgroundColor: Colors.yellow.shade50,
        title: Text(widget.title,style: AppTheme.initTheme.textTheme.headline2,),
        actions: [
          IconButton(icon: const Icon(Icons.person), onPressed: () {}),
        ],
      )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: kSpacing),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                child: Column(
                  children: [
                    const SizedBox(height: kSpacing),
                    Text(widget.title),
                    Container(color: Colors.white60, height: 900),
                    const SizedBox(height: kSpacing),
                    const SizedBox(height: kSpacing * 2),
                    const SizedBox(height: kSpacing),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
 