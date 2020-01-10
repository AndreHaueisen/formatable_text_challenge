import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:formatable_text/state/app_state.dart';
import 'package:formatable_text/widgets/formatable_text.dart';

// The objective: https://faq.whatsapp.com/en/android/26000002/
// Two observations:
// 1 - Bold tag is not * as in the description. I used @ instead because RegEx was not detecting * appropriately
// 2 - it doesn't support monospace because there isn't an easy way to do this in Flutter. To the best of my knowledge, it would require a custom painter

Store<AppState> store;

void main() {
  var state = AppState.initialState();
  store = Store<AppState>(initialState: state);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _controller = TextEditingController(text: '');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Spacer(),
            Flexible(child: FormatableText(phrase: _controller.value.text)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(),
                onChanged: (text){
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
