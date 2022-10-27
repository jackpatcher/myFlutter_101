part of sys_mid;

class SysM1BodyCard extends StatelessWidget {
  SysM1BodyCard({Key? key}) : super(key: key);

  List<SysM1BodyCardData> cards = getCards();

  @override
  Widget build(BuildContext context) {
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
            child: buildCards(cards[index], index, sys_getSequenceColor(index)),
          ),
        ),
      ),
    );
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
          ), elevation: 5,
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
                            _buildProgress(card, color,card.numberRegist/card.total),
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
        Icon(card.icon, color: Colors.white , ),
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
                "  / " + card.total.toString(),
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

  _buildProgress(card, color,double percent) {
    return Row(children: [
      Text(
         (percent*100).toStringAsFixed(0) + " %",
        style: TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.w900),
      ),
      Expanded(
        child: LinearPercentIndicator(
          animation: true,
          animationDuration: 500,
          percent:  percent,
          progressColor: Colors.white.withOpacity(.7),
          backgroundColor: color,
        ),
      ),
    ]);
  }
}

 
