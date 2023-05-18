import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final Color grey1 = Color.fromRGBO(91, 91, 91, 1.0);
final Color grey2 = Color.fromRGBO(138, 138, 138, 1.0);
final Color grey3 = Color.fromRGBO(225, 225, 225, 1.0);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget discover = DiscoverPage();
    Widget feed = FeedPage();
    return ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MaterialApp(
          home: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  toolbarHeight: 40,
                  bottom: PreferredSize(
                    preferredSize: Size(360, 38.0),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.fromLTRB(16, 0, 0, 5),
                      child: TabBar(
                        isScrollable: true,
                        labelColor: Colors.black,
                        unselectedLabelColor:
                            Color.fromRGBO(209, 209, 209, 1.0),
                        indicatorColor: Colors.transparent,
                        tabs: [
                          Tab(
                            child: SizedBox(
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Text("Discover",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ),
                          Tab(
                            child: SizedBox(
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Text('Feed',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              body: TabBarView(
                children: [
                  discover,
                  feed,
                ],
              ),
            ),
          ),
        ));
  }
}

class MyAppState extends ChangeNotifier {}

Widget tabWidget() {
  return Tab(
    child: SizedBox(
      child: Container(
        alignment: Alignment.bottomLeft,
        child: Text('test',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
      ),
    ),
  );
}

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [sliderWidget()],
          ),
        )
      ],
    );
  }
}

Widget sliderWidget() {
  final List<String> bannerEntries = <String>[
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRI3ymLrtPVCgQAsQfVghW6yzQH1CpWBY8HjbNfGD_JvCYOB5nyAG0x8e7KWo_Rzv_x9s8&usqp=CAU',
    'https://imgv3.fotor.com/images/blog-cover-image/part-blurry-image.jpg',
    'https://thumbs.dreamstime.com/b/beautiful-rain-forest-ang-ka-nature-trail-doi-inthanon-national-park-thailand-36703721.jpg',
  ];

  final PageController controller = PageController();
  return PageView.builder(
    controller: controller,
    itemCount: bannerEntries.length,
    itemBuilder: ((context, index) => SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Image(
              fit: BoxFit.cover, image: NetworkImage(bannerEntries[index])),
        )),
  );
}

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        hashtagList(),
        feedList(),
      ],
    ));
  }
}

Widget hashtagList() {
  final List<String> entries = <String>[
    'All',
    'Highlights',
    'Urgent',
    'Wanted',
    'Sponsors',
    'Pitch',
    'Pickup Football',
    'Tips',
    'Reviewers',
    'Giveaway',
    'etc'
  ];
  return Container(
    padding: const EdgeInsets.all(8),
    child: SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.all(4),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Color.fromRGBO(225, 225, 225, 1.0),
              ),
            ),
            child: Center(child: Text(entries[index])),
          );
        },
        separatorBuilder: ((context, index) => const SizedBox(
              width: 4,
            )),
      ),
    ),
  );
}

Widget feedList() {
  return ListView(
    scrollDirection: Axis.vertical,
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: <Widget>[
      ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return feedCard();
          }),
    ],
  );
}

Widget feedCard() {
  final iconStyle = MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.pressed)) {
      return Colors.black;
    }
    return grey2;
  });
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ListTile(
        leading: SizedBox(
            height: double.infinity,
            width: 32,
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(57, 255, 159, 1),
              child: Text('MF',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Color.fromRGBO(46, 171, 111, 1))),
            )),
        title: Text(
          'Brian Smith',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          'Southwest London',
          style: TextStyle(fontSize: 12),
        ),
        trailing: Icon(Icons.more_vert),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur sit amet lacus et risus euismod egestas. Nullam aliquet ex vitae turpis commodo, a convallis felis gravidaa.',
          style: TextStyle(
              color: grey1, fontWeight: FontWeight.w400, fontSize: 12),
        ),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: SizedBox(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Color.fromRGBO(225, 225, 225, 1.0),
            ),
          ),
          child: SizedBox(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Text(
                      style: TextStyle(color: grey1, fontSize: 12),
                      '# highlights'))),
        )),
      ),
      SizedBox(
        height: 355,
        child: Image(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://media.cnn.com/api/v1/images/stellar/prod/221126143352-weston-mckennie.jpg?c=original')),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                TextButton.icon(
                  style: ButtonStyle(iconColor: iconStyle),
                  icon: Icon(
                    Icons.rocket_outlined,
                    size: 20,
                  ),
                  label: Text(
                    '208C',
                    style: TextStyle(color: grey2),
                  ),
                  onPressed: () {/* ... */},
                ),
                TextButton.icon(
                  style: ButtonStyle(iconColor: iconStyle),
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    size: 20,
                  ),
                  label: Text(
                    '3',
                    style: TextStyle(color: grey2),
                  ),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
            Icon(
              Icons.share_outlined,
              color: grey2,
              size: 20,
            ),
          ],
        ),
      ),
    ],
  );
}
