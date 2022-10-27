part of dashboard;

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.basic.primaryColor,
      elevation: 0,
      title: Row(children: const [
        Icon(Icons.drive_file_rename_outline),
        Spacer(),
        Text(' Dinsor OS'),
          Spacer(),
      ]),
      
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.person),
        ),
        IconButton(
          icon: const Icon(Icons.language),
          tooltip: 'Show Snackbar',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('This is a snackbar')));
          },
        ),
        IconButton(
          icon: const Icon(Icons.navigate_next),
          tooltip: 'Go to the next page',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Next page'),
                  ),
                  body: const Center(
                    child: Text(
                      'This is the next page',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
            ));
          },
        ),
      ],
    );
  }
}
