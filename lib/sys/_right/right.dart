part of dashboard;

class SysRightSection extends StatefulWidget {
  const SysRightSection({Key? key}) : super(key: key);

  @override
  State<SysRightSection> createState() => _SysRightSectionState();
}

class _SysRightSectionState extends State<SysRightSection> {
  late List<SysR1BodyTaskData> tasks;
  @override
  void initState() {
    super.initState();
    tasks = getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return rightSection();
  }

  Widget rightSection() {
    return ViewPaperTopCorner(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpacing),
        child: Column(
          children: [
            const SizedBox(height: kSpacing),
            Row(
              children: [
                const Expanded(child: HeaderText("RA bar")),
                IconButton(
                  icon: const Icon(EvaIcons.calendarOutline),
                  tooltip: "calendar",
                  onPressed: () {},
                ),
              ],
            ),
            Container(
              height: 50.0,
              width: 600,
              color: Colors.red,
            ),
            HeaderText("TEst"),
            const Text("TEst"),
            const Text("TEst"),
            const Text("TEst"),
            const Text("TEst"),
            const Text("TEst"),
            const Text("TEst"),
            const Text("TEst"),
            const Text("TEst"),
            const Text("TEst"),
            const Text("TEst"),
            const Text("TEst"),
            const Text("TEst"),
            const Text("TEst"),
            const Text("TEst"),
            const Text("TEst"),
            const Text("TEst"),
            const Text("TEst"),
            const Text("TEst"),
            const Text("TEst"),
          ],
        ),
      ),
    );
  }

  Widget genListTask() {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(tasks[index].label),
        );
      },
    );
  }
}
