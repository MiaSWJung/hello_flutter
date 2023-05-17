import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            length: 2,
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
                            child: Container(
                              width: 93,
                              alignment: Alignment.bottomLeft,
                              child: Text("Discover",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                          Tab(
                            child: Container(
                              width: 60,
                              alignment: Alignment.bottomLeft,
                              child: Text('Feed',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
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

// https://youtu.be/PHdq1WnheHo
class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('discover');
  }
}

// https://docs.flutter.dev/cookbook/lists/horizontal-list
class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

    return Column(
      children: [
        SizedBox(
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
      ],
    );
  }
}
