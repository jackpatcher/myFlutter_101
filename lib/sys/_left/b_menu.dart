part of dashboard;

class _TaskMenu extends StatelessWidget {
  const _TaskMenu({ Key? key,}) : super(key: key);

 


  @override
  Widget build(BuildContext context) {
    return SimpleSelectionButton(
      data: const [
        "Directory",
        "Onboarding",
        "Offboarding",
        "Time-off",
      ], onSelected: (int index, String value) {  },
      
    );
  }

    
}
