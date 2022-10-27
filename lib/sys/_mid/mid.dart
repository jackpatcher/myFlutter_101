part of dashboard;

class SysMidSection extends StatefulWidget {
  const SysMidSection({Key? key}) : super(key: key);

  @override
  State<SysMidSection> createState() => _SysMidSectionState();
}

class _SysMidSectionState extends State<SysMidSection> {
  @override
  Widget build(BuildContext context) {
    return midSection();
  }

  Widget midSection() {
    const double borderPage = 15;

    return ViewPaperTopCorner (
      child: Column(
        children: [
          const SizedBox(height: kSpacing),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSpacing),
            child: Column(
              children: [
                const SizedBox(height: kSpacing),
                Row(
                  children: const <Widget>[
                    Expanded(
                      child: SysM1head(),
                    ),
                  ],
                ),
                const SizedBox(height: kSpacing),
                const SizedBox(height: kSpacing),
                SysM1BodyCard(),
                const SizedBox(height: kSpacing * 2),
                const SysM2head(),
                const TaskProgress(),
                const SizedBox(height: kSpacing),
                const SysM2Body(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
