import 'package:flutter/material.dart';
import 'package:gsheet2/services/gsheet.dart';

class AddPage extends StatefulWidget {
  final GoogleSheetsProvider provider;
  const AddPage({required this.provider, Key? key}) : super(key: key);

  @override
  AddPageState createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Std"),
      ),
      body: Center(
        child: SizedBox(
          width: size > 300 ? 300 : size,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// House name
              TextFormField(
                controller: _firstNameController,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(hintText: "Std firstName"),
              ),

              const SizedBox(
                height: 12.0,
              ),

              /// House name
              TextFormField(
                controller: _lastNameController,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(hintText: "Std lastName"),
              ),

              const SizedBox(
                height: 12.0,
              ),

              MaterialButton(
                  child: const Text(
                    'Add Std',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    await widget.provider.addStd(
                        _firstNameController.text, _lastNameController.text);
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}