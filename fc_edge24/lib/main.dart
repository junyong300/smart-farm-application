import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'webview_page.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'page_home.dart';
// import 'page_espd.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
  //   await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: 'FC EDGE 2024  Home Page'),
      title: 'FC EDGE 2024',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const PageHome(),
    // const PageEspd(),
    const PageEspdLegacy(),
    const PageFrutnet(),
    PageMultiSensor(),
    PageConnectOn(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FarmConnect Edge AI app'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: navBar(),
    );
  }

  BottomNavigationBar navBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          // icon: Icon(Icons.search),
          icon: Text("ESPD"),
          label: '(생육)',
        ),
        BottomNavigationBarItem(
          icon: Text("FRUTNET"),
          label: '(성장)',
        ),
        BottomNavigationBarItem(
          icon: Text("멀티센서"),
          label: '(환경)',
        ),
        BottomNavigationBarItem(
          icon: Text("ConnectOn"),
          label: '(환경)',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.grey, // 선택되지 않은 항목 색상 지정
      showSelectedLabels: true,
      showUnselectedLabels: true, // 선택되지 않은 항목의 라벨도 표시
      onTap: _onItemTapped,
      backgroundColor: Colors.white, // 배경색 지정
      type: BottomNavigationBarType.fixed, // 아이템이 4개 이하일 때 권장
    );
  }
}

class PageFrutnet extends StatelessWidget {
  const PageFrutnet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Text('3. Page'),
      Text('Page FRUTNET'),
    ]));
  }
}

class PageEspd extends StatelessWidget {
  const PageEspd({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Button Pressed')),
                );
              },
              child: const Text(
                'ESPD',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('사진 선택'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('  '),
                  ),
                ),
                // Add more buttons as needed
              ],
            ),
            const Text(
              """
# 병충해 확인
* 발생일자 : 2024-06-01
* 추론결과 : 잎곰팡이병(Leaf mold)

# 진단 결과
    2024-06-01 111111111.png 진단 : 정상
 √ 2024-06-01 221111111.png 진단 : Leaf mold
    2024-06-01 331111111.png 진단 : chlorosis virus
""",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // 간격 추가
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('결과 전송'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('삭제'),
                  ),
                ),
                // Add more buttons as needed
              ],
            ),
          ],
        ));
  }
}

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Button Pressed')),
                );
              },
              child: const Text(
                '앱',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            const Text(" # 앱 : FC EDGE 2024\n",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            const Text(
              """
# 생육 : ESPD
  * 이미지 등을 활용한 사용법 안내

# 성장 : FRTUNET
 * 이미지 등을 활용한 사용법 안내
 * 
# 환경 : 멀티센서
 * 이미지 등을 활용한 사용법 안내

# CONNECT ON 
  * 팜커넥트앱 커넥트온 연결
  
# 앱 정보
이 앱은 2024년도 정부(과학기술정보통신부)의 재원으로 정보통신기획평가원의 지원을 받아 수행된 연구임(No. 2021-0-00907 능동적 즉시 대응 및 빠른 학습이 가능한 적응형 경량 엣지 연동분석 기술개발).

""",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // 간격 추가
            // ElevatedButton(
            //   onPressed: () {
            //     // 버튼이 눌렸을 때의 동작 정의
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(content: Text('Button Pressed')),
            //     );
            //   },
            //   child: Text('생육'),
            // ),
          ],
        ));
  }
}

class PageMultiSensor extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  //   return Text('11');
  // }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest:
          URLRequest(url: WebUri('https://testfarm.farmcloud.kr/multisensor')),
    );
  }
}

class PageConnectOn extends StatelessWidget {
  const PageConnectOn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest:
          URLRequest(url: WebUri('https://testfarm.farmcloud.kr/app')),
    );
  }
}

class PageEspdLegacy extends StatelessWidget {
  const PageEspdLegacy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest:
          URLRequest(url: WebUri('https://smartca.farmcloud.kr/espd')),
    );
  }
}
