
import 'package:async_redux/async_redux.dart';
import 'package:formatable_text/state/app_state.dart';


class ChangeTextAction extends ReduxAction<AppState> {

  final String newText;

  ChangeTextAction(this.newText);

  @override
  AppState reduce() {
    print('change text action called');
    return state.copy(
      changeTextEvt: Event<String>(newText),
    );
  }
}