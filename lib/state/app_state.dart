
import 'package:async_redux/async_redux.dart';

class AppState {

  final Event clearTextEvt;
  final Event<String> changeTextEvt;

  AppState({this.clearTextEvt, this.changeTextEvt});

  AppState copy({int counter, bool waiting, Event clearTextEvt, Event<String> changeTextEvt}) =>
      AppState(
        clearTextEvt: clearTextEvt ?? this.clearTextEvt,
        changeTextEvt: changeTextEvt ?? this.changeTextEvt,
      );

  static AppState initialState() => AppState(
    clearTextEvt: Event.spent(),
    changeTextEvt: Event<String>.spent(),
  );
  
}