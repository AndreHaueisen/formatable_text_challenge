
import 'package:async_redux/async_redux.dart';
import 'package:formatable_text/state/app_state.dart';

class ClearTextAction extends ReduxAction<AppState> {
  @override
  AppState reduce() => state.copy(clearTextEvt: Event());
}