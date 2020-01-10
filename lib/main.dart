import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:formatable_text/page_connector.dart';
import 'package:formatable_text/state/app_state.dart';

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
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PageConnector(),
      ),
    );
  }
}
