
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:formatable_text/actions/change_text_action.dart';

class AppState {

  final Event<String> changeTextEvt;

  AppState({this.changeTextEvt});

  AppState copy({int counter, bool waiting, Event<String> changeTextEvt}) =>
      AppState(
        changeTextEvt: changeTextEvt ?? this.changeTextEvt,
      );

  static AppState initialState() => AppState(
    changeTextEvt: Event<String>.spent(),
  );
  
}