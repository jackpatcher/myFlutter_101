import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../theme.dart';



class Page1 extends StatefulWidget {
  final String title;

  const Page1({
    super.key,
    required this.title,
  });

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List<P1CardsData> cards = getCards();

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
                    _getCardsRect(),
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

  Widget _getCardsRect() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kBorderRadius * 1),
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: cards.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSpacing / 2),
            child: buildCards(cards[index], index,  getSequenceColor(index)),
          ),
        ),
      ),
    );
  }
}

Widget buildCards(card, index, color) {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0),
      bottomRight: Radius.circular(20.0),
      bottomLeft: Radius.circular(20.0),
    ),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(4),
      child: Material(
        child: InkWell(
          onTap: () {
            debugPrint("card clicked");
          },
          child: Container(
            width: 179,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(.7)],
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
              ),
            ),
            child: BackgroundDecoration(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildHeaderCard(card, index),
                          //const SizedBox(height: 20),
                          _buildNumberCard(card, index, color),
                          _buildProgress(
                              card, color, card.numberRegist / card.total),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildHeaderCard(card, index) {
  return Row(
    children: [
      Icon(
        card.icon,
        color: Colors.white,
      ),
      const Spacer(),
      Text(
        card.label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

Widget _buildNumberCard(card, index, color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Center(
      child: Column(
        children: [
          Row(children: [
            Text(
              card.numberRegist.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "  / ${card.total}",
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
          ]),
        ],
      ),
    ),
  );
}

_buildProgress(card, color, double percent) {
  return Row(children: [
    Text(
      "${(percent * 100).toStringAsFixed(0)} %",
      style: const TextStyle(
          fontSize: 12, color: Colors.white, fontWeight: FontWeight.w900),
    ),
    Expanded(
      child: LinearPercentIndicator(
        animation: true,
        animationDuration: 500,
        percent: percent,
        progressColor: Colors.white.withOpacity(.7),
        backgroundColor: color,
      ),
    ),
  ]);
}

class P1CardsData {
  final String label;
  final int numberRegist;
  final int total;
  final IconData icon;

  const P1CardsData({
    required this.label,
    required this.numberRegist,
    required this.total,
    required this.icon,
  });
}

List<P1CardsData> getCards() => const [
      P1CardsData(
        label: "นักเรียนที่สมัคร",
        numberRegist: 1050,
        total: 1500,
        icon: Icons.person,
      ),
      P1CardsData(
        label: "จำนวนคอร์ส",
        numberRegist: 20,
        total: 56,
        icon: Icons.supervisor_account,
      ),
      P1CardsData(
        label: "การส่งงาน",
        numberRegist: 200,
        total: 1500,
        icon: Icons.escalator_warning,
      ),
      P1CardsData(
        label: "เรียนย้อนหลังแล้ว",
        numberRegist: 20,
        total: 26,
        icon: Icons.lock_person,
      )
    ];

class BackgroundDecoration extends StatelessWidget {
  const BackgroundDecoration({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Transform.translate(
            offset: const Offset(25, -35),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white.withOpacity(.1),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Transform.translate(
            offset: const Offset(-1, 10),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withOpacity(.2),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

