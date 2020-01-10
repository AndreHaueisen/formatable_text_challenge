
import 'package:async_redux/async_redux.dart';
import 'package:formatable_text/state/app_state.dart';


class ChangeTextAction extends ReduxAction<AppState> {

  @override
  AppState reduce() {
    String newText = state.changeTextEvt.state;
    return state.copy(
      changeTextEvt: Event<String>(newText),
    );
  }
}