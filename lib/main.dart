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
                bottom: const TabBar(
                  tabs: [
                    Text('Discover'),
                    Text('Feed'),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  Text('test'),
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
