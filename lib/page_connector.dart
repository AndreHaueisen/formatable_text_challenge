import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:formatable_text/page.dart';
import 'package:formatable_text/state/app_state.dart';

class PageConnector extends StatelessWidget {
  PageConnector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => Page(
        changeTextEvt: vm.changeTextEvt,
        onTextChange: vm.onChange,
      ),
    );
  }
}