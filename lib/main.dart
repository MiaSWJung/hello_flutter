import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 질문 :
// 2. class 형 variable 을 정의할 때 ClassName variableName 형식을 띄는데,(ex. IconData icon)
//  변수 정의할 때 void 대신에 type assertion 으로 정의하는 건가

// 3. notifyListeners vs setState
//  직관적 예상: notifyListeners는 MyApp 내에서 전역 state 변경 noti이고, setState 는 위젯내부 state 변경 noti인가?
// A. setState는 StatefulWidget 안에서 쓸 수 있는게 맞다.
//    다만,setState가 트리거 되면 그 상태가 포함된 위젯 전체가 리렌더링 된다.
//    notifyListeners는 context notify, watch 로 관리한다. 이때 watch 하는 부분만 리렌더링 되므로, 비용이 적다.

// 4. Padding을 부모 위젯으로 잡고 child를 포함하다니.. 낯설다
//  그리고 Padding 파라미터 멤버에는 children[] 가 없다(쓸수없다)..!
//  호버했을떄 뜨는 가이드 따라 basic.dart 탐색해보니 SingleChildRenderObjectWidget 는 child로 단일 요소를 자식으로 갖는 것 같다.
//  children, child 를
//  ListView 의 child인 Padding widget 에서..

// 5. 복잡한, depth가 깊은 위젯(컴포넌트)는 child 트리가 엄청 깊어질것같은데,
//    컴포넌트 디자인 모델전략을 어떻게 취하는지 궁금하다.
//    우리 서비스에서는 불가피하게 현재 외주팀에서 짜놓은 것 바탕으로 해야겠지만 ..
// 프로젝트 파일구조는 재활용

// 6. ListView, GridView, Row, Column 사이에 gap 을 주고싶은데, 찾아보니 SizedBox를 놓거나, spacer, MainAxisAlignment.spaceAround ,spaceBetween  등으로 해결하는 방법이 있었다.
//   https://stackoverflow.com/questions/53141752/set-the-space-between-elements-in-row-flutter
//   웹의 gap 처럼 요소 사이마다 지정 pixel을 주어서 갭을 줄 수 는 없는건가..
//  A. flutter/widgets/ListView-class 보기 ! 다른 위젯에서 떠오르는 비슷한 질문은 공식문서에서 웬만한걸 해결할 수 있다.

// 7. 구현이 어려운 UI
//  + Infinity Scroll + Windowing 뷰포트에 보여야하는 위젯으로 갈아끼우는것 -> 위젯트리가 비대해지는 것 예방
// 가능하면 내부에서 지원하는 위젯을 사용하고, 복잡한 UI 를 꼭 구현해야 한다면 package를 사용하라.
//  Flutter를 포함한 요즘의 UI 엔진이 메모리 관리를 하는 방식을 생각하면 , windowing 이 필수가 아니다. (맞아 Next.js 도 레이지로드 하쟈나~ 충격..)
//  뷰포트 밖에 있는 요소들을 모두 픽셀로 갖고 있는게 아니라, object의 텍스트 데이터만 갖고있다.

// 느낀점 :
// 1. Flutter 는 내장된 메소드, 위젯 (특히 UI widget), 아이콘들이 꽤 버라이어티해보인다.
//  네이티브 언어도 이런 느낌일 것 같다는 생각이 든다. 잘 알고 사용하는 것이 관건일 듯 하다.
// from material library
// A. 보통 material design(v3) 에 따른다. 좋은 방법은 샘플을 많이 보는 것.
//   또다른 방법은 Flutter 공식 유툽에서 제공하는 Flutter Widget of the Week 을 보자.

// 2. SafeArea 아주 나이스... PWA에서 고민거리였던 문제.
// 3. 코드? 끝단 가이드가 있어서 참 다행이다...
//    Flutter가 개발경험 측면에서 단점이 Code Nesring level이 상당히 높다고 해서 걱정했는데 (JS 처음 배울때 오류많이냈다..)

// 팁 :
// 1. 문서에서 아이콘 찾기가 좀 빡센데, metarial icon 네임과 동일하다고 한다. 잘 정리해둔 곳에서 찾으면 될듯
//  https://api.flutter.dev/flutter/material/Icons-class.html#constants
//  https://mui.com/material-ui/material-icons/

// 알아낸것
// 1. @override 의미, 역할
//  함수가 조상 클래스에서도 정의되었지만 현재 클래스에서 다른 작업을 수행하도록 재정의되고 있음을 지적합니다. 또한 추상 메서드의 구현에 주석을 추가하는 데 사용됩니다. 사용은 선택 사항이지만 가독성을 향상시키므로 권장됩니다.

// 7. final 은 뭘까.. const 같은건가
//  = 맞다! 클래스에서 final을 사용해서 인스턴스를 생성할 때, 상수를 설정할 수 있습니다.

// 8.  StatefulWidget vs StatelessWidget
//  stateful widget : a subclass of StatefulWidget and a subclass of State.

// 더 공부할 것
// 1. cache and network - image 최적화 - flutter youtube 채널에 있음
// 2. 사이즈가 각기 다른 모바일에 대응하는 올바른 전략은?
//  A. Expanded 를 사용해보자. 웹의 Flex=1 또는 비율분 과 같은 역할

void main() {
  runApp(const MyApp());
}

// Widget : 모든 Flutter App을 빌드하는데 사용되는 elements.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'My First Flutter',
        // This is the theme of your application.
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
        // home: MyHomePage(),
        home: MyHomePageWithNavi(),
      ),
    );
  }
}

// App 상태 정의 : defines the data the app needs to function
class MyAppState extends ChangeNotifier {
  // WordPair가 변하면 some widgets in the app에 노티된다 by ChangeNotifier
  //  이 state는 ChangeNotifierProvider를 사용하는 앱 전체에 제공된다.
  //  앱의 모든 위젯에서 상태를 확인할 수 있다.
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void deleteFavorite(pair) {
    if (favorites.isEmpty == false && favorites.contains(pair)) {
      favorites.remove(pair);
      notifyListeners();
    }
  }
}

// class MyHomePageWithNavi extends StatelessWidget
//  : 내부에서 state관리를 하지않고, MyAppState 에서 내려주는 상태를 받는다.
//  -> Cmd . -> Convert to StatefulWidget
//  : 내부에서만 사용하는 State를 관리할 수 있는 위젯으로 컨버팅
class MyHomePageWithNavi extends StatefulWidget {
  @override
  State<MyHomePageWithNavi> createState() => _MyHomePageWithNaviState();
}

// underscore(_) class name prefix : 해당 클래스를 비공개로 만들고 컴파일러에 의해 강제 적용됩니다.
class _MyHomePageWithNaviState extends State<MyHomePageWithNavi> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritePage();
        break;
      default:
        throw UnimplementedError('no wiget for $selectedIndex');
    }

    // return Scaffold -> Wrap with Builder -> Builder로 래핑됨
    //  parameter 멤버로 constraints를 받는 LayoutBuilder로 변경(from Builder).
    //  constraints가 변경되는 이벤트 : resize window , rotate portrait of mobile device , 위젯크기가 바뀔 때 등
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(children: [
          // SafeArea는 child이 하드웨어 노치나 status bar에 가려지지 않도록 해줍니다.
          //  예를 들어 이 앱에서는 위젯이 내비게이션 버튼이 모바일 상태 표시줄에 가려지는 것을 방지하기 위해 NavigationRail을 감싸고 있습니다.
          SafeArea(
              // NavigationRail doesn't automatically show labels when there's enough space
              //  because it can't know what is enough space in every context.
              // 사양에 따라 사용 가능한 공간에 자식을 자동으로 맞추는 위젯인 FittedBox도 있습니다.
              child: NavigationRail(
            // extended: true 일 경우 label 까지 확장 노출
            // app has enough horizontal space 일 때 자동으로 값이 토글되도록 할 수 있다.
            extended: constraints.maxWidth >= 600,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite),
                label: Text('favorates'),
              )
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          )),
          Expanded(
              child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: page,
          ))
        ]),
      );
    });
  }
}

class MyHomePage extends StatelessWidget {
  @override
  // 모든 widget 은 build() method를 정의한다 : 위젯이 항상 최신 상태를 유지하도록 위젯의 상황이 바뀔 때마다 자동으로 호출된다.
  // 모든 위젯은 위젯의 상황이 변경될 때마다 자동으로 호출되는 build() 메서드를 정의하여 위젯을 항상 최신 상태로 유지한다.
  Widget build(BuildContext context) {
    // MyHomePage는 watch method 를 사용하여 앱의 현재 상태에 대한 변경 사항을 추적합니다.
    var appState = context.watch<MyAppState>();

    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    // 모든 build method는 위젯이나 위젯의 중첩된 트리를 반환해야 합니다.
    //  이 경우 최상위 위젯은 Scaffold입니다.
    return Scaffold(
      // Column은 Flutter에서 가장 기본적인 레이아웃 위젯 중 하나입니다.
      //  Column은 원하는 수의 children을 가져와서 위에서 아래로 열에 배치합니다.
      //  By default, Column은 시각적으로 자식을 맨 위에 배치합니다.
      // Cmd . ->  Wrap With Center => Column -> Center
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // 첫 번째 단계에서 이 텍스트 위젯을 변경했습니다.
          Text('A random AWESOME idea : '),
          // 이 두 번째 텍스트 위젯은 appState를 취하고 해당 클래스의 유일한 멤버인 current(WordPair)에 액세스합니다.
          //  WordPair는 몇 가지 유용한 게터(asPascalCase 또는 asSnakeCase 등)를 제공합니다.
          //  Text(appState.current.asLowerCase),

          // Text widget no longer refers to the whole appState
          //  appState.current.asLowerCase -> pair.asLowerCase
          // step0.
          // Text(pair.asLowerCase)
          // step1. refactor : Cmd . -> Extract Widget -> BigCard
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                  icon: Icon(icon),
                  label: Text('Like')),
              ElevatedButton(
                  onPressed: () {
                    print('button pressed!');
                    appState.getNext();
                  },
                  child: Text('Next')),
            ],
          )
        ]),
      ),
    );
  }
}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have ${appState.favorites.length} favorite'),
        ),
        for (var pair in appState.favorites)
          ListTile(
              leading: ElevatedButton(
                  onPressed: () {
                    appState.deleteFavorite(pair);
                  },
                  child: Icon(Icons.delete)),
              title: Text(pair.asLowerCase))
        // messages.map((m) => Text(m)).toList(),
      ],
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        BigCard(pair: pair),
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                appState.toggleFavorite();
              },
              icon: Icon(icon),
              label: Text('Like'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'))
          ],
        )
      ]),
    );
  }
}

// automatically created by Extract Widget
class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 1.theme.textTheme를 사용하면 앱의 글꼴 테마에 액세스할 수 있습니다.
    //  displayMedium 속성은 이론적으로 null일 수 있습니다.
    //  Dart는 null-safe이므로 null인 객체의 메서드를 호출할 수 없습니다(potentially).
    //  하지만 이 경우 ! 연산자(bang operator)를 사용하여 Dart에 자신이 무엇을 하고 있는지 알릴 수 있습니다.
    // 2. displayMedium에서 copyWith()를 호출하면 사용자가 정의한 변경 사항이 포함된 텍스트 스타일의 복사본이 반환됩니다.
    //    변경 가능한 전체 속성 보기 :Cmd+Shift+Space
    final firstStyle = theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w100);
    final secondStyle = theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w700);

    // step2. Cmd . -> Wrap with Padding
    // return Text(pair.asLowerCase)

    // Flutter는 가능한 한 상속(Inheritance)보다 컴포지션을 사용합니다.
    //  여기서는 Padding이 Text의 속성(attribute)이 아니라 위젯입니다!
    //    이렇게 하면 위젯은 한 가지 책임에만 집중할 수 있고 개발자는 UI를 구성하는 방법을 완전히 자유롭게 결정할 수 있습니다.
    //    예를 들어 Padding 위젯을 사용하여 텍스트, 이미지, 버튼, 사용자 정의 위젯 또는 앱 전체에 패딩을 적용할 수 있습니다.
    //    위젯은 무엇을 감싸는지는 신경 쓰지 않습니다.
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Text(pair.asLowerCase),
    // );

// here
    // step3. Padding Cmd . -> Wrap with Widget -> switch Wiget to Card
    return Card(
        color: theme.colorScheme.primary,
        child: Padding(
            padding: const EdgeInsets.all(20),
            // Flutter는 앱 접근성을 위해 TalkBack, VoiceOver 등을 제공한다.
            //  그러나, 합성어(ex.cheaphead)를 잘못 발음할 가능성이 있다.
            // child: Text(pair.asLowerCase, style: style),
            child: RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(text: pair.first, style: firstStyle),
              TextSpan(text: pair.second, style: secondStyle)
            ]))
            // Text(
            //   pair.asLowerCase,
            //   style: style,
            //   // Flutter에는 automated tests 및 Semantics widget을 비롯한 접근성을 위한 다양한 도구가 있습니다.
            //   semanticsLabel: "${pair.first} ${pair.second}",
            // )
            // TextSpan(children: [Text(pair.first)])),
            ));
  }
}
