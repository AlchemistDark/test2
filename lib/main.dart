import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Счётчик.
  int _counter = 0;
  late final SharedPreferences _prefs;

  bool _init = false;

  @override
  void initState(){
    super.initState();
    _initialise();
  }

  Future<void> _initialise() async {
    _prefs = await SharedPreferences.getInstance(); // Ссылка на объект базы данных.
    _counter = _prefs.getInt('counter') ?? 0;
    _init = true;
    setState((){});
  }

  /// Увеличивает счётчик и сохраняет в базу.
  _increment() async{
    //_counter = _prefs.getInt('counter') ?? 0;
    _counter++;
    await _prefs.setInt("counter", _counter);
  }

  /// Я добавил это потому, что async занимает время, а в виджет что-то выводить надо.
  String str(){
    if (_counter == 0) {
      return "Жми уже!";
    }
    return _counter.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (!_init) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Кто это прочитал, тот чипсов захотел :)"),
        ),
        body: Center(
          child: Text("грузиццо"),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Кто это прочитал, тот чипсов захотел :)"),
      ),
      body: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              str(),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){setState(() {
          _increment();
        });},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
